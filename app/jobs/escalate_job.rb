class EscalateJob < ApplicationJob
  # Sends channel[step], then re-enqueues itself for the next channel after escalate_after_seconds.
  # Self-chains until you ack (needs_blast? false) or the channels run out.
  def perform(meeting_id, step = 0)
    meeting = Meeting.find(meeting_id)
    return unless meeting.needs_blast?

    channel = meeting.setting.channels[step] or return
    mode = step.zero? && meeting.setting.confirm_nudge ? :confirm : :blast
    Sender.for(channel, meeting).deliver(mode)
    meeting.update_column(:notified_at, Time.current)

    self.class.set(wait: meeting.setting.escalate_after_seconds.seconds).perform_later(meeting_id, step + 1)
  end
end
