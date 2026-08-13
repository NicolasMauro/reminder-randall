require "icalendar"

class SyncCalendarJob < ApplicationJob
  MEET = %r{https://[\w./-]*(?:meet\.google\.com|zoom\.us|teams\.microsoft\.com|whereby\.com)[\w./?=&%-]*}i

  def perform(user_id = nil)
    scope = user_id ? User.where(id: user_id) : User.where.not(ics_url: [ nil, "" ])
    scope.find_each { |user| sync(user) }
  end

  private
    def sync(user)
      cal = Icalendar::Calendar.parse(Http.get(user.ics_url)).first or return
      cal.events.each { |event| import(user, event) }
    end

    def import(user, event)
      starts = event.dtstart&.to_time or return
      return unless starts.between?(Time.current, 24.hours.from_now)
      url = link(event) or return

      meeting = user.meetings.find_or_initialize_by(uid: event.uid.to_s)
      fresh = meeting.new_record?
      meeting.update!(title: event.summary.to_s, starts_at: starts, join_url: url,
                      provider: provider(url), hosting: hosting?(user, event))
      meeting.schedule! if fresh
    end

    def link(event) = [ event.location, event.description, event.url ].join(" ")[MEET, 0]

    def provider(url)
      case url
      when /meet\.google/ then "meet"
      when /zoom/         then "zoom"
      when /teams/        then "teams"
      when /whereby/      then "whereby"
      else "other"
      end
    end

    def hosting?(user, event)
      user.email.present? && event.organizer.to_s.downcase.include?(user.email.downcase)
    end
end
