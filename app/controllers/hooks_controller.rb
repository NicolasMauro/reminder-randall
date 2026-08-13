class HooksController < ApplicationController
  skip_forgery_protection

  # Inbound "IN" reply from LoopMessage / Twilio silences the newest pending meeting.
  def loopmessage = ack_from(params[:recipient], params[:text])
  def twilio      = ack_from(params[:From], params[:Body])

  private
    def ack_from(phone, text)
      if text.to_s.match?(/\bin\b/i)
        User.find_by(phone: phone.to_s.delete_prefix("whatsapp:"))
            &.meetings&.pending&.order(:starts_at)&.first&.ack!
      end
      head :ok
    end
end
