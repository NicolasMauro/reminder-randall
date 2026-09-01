module Copy
  module_function

  def text(meeting, mode = :blast)
    case mode
    when :lead
      %(🥊 Randall: "#{meeting.title}" starts in #{meeting.setting.lead_minutes} min. #{meeting.join_url})
    when :confirm
      %(🥊 Randall: you're in "#{meeting.title}", right? Reply IN if so, or tap #{ack_url(meeting)}.)
    else
      %(🥊 Randall: "#{meeting.title}" started #{meeting.minutes_late} min ago and you're not in. ) +
      %(Join: #{meeting.join_url} — reply IN or tap #{ack_url(meeting)} to stop.)
    end
  end

  def subject(meeting, mode)
    mode == :lead ? %(Starts in #{meeting.setting.lead_minutes} min: #{meeting.title}) : %(🥊 You're missing "#{meeting.title}")
  end

  def ack_url(meeting) = Rails.application.routes.url_helpers.meeting_ack_url(meeting.token)
end
