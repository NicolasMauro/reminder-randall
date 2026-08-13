class LeadReminderJob < ApplicationJob
  # Optional heads-up N minutes before start. One ping on the top channel, no escalation.
  def perform(meeting_id)
    meeting = Meeting.find(meeting_id)
    return if meeting.acknowledged?
    Sender.for(meeting.setting.channels.first, meeting).deliver(:lead)
  end
end
