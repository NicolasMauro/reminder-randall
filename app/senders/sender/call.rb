class Sender::Call < Sender::Base
  def deliver(mode = :blast)
    Twilio.call(from: ENV.fetch("TWILIO_CALL_FROM"), to: user.phone,
                twiml: "<Response><Say voice=\"Polly.Matthew\">#{spoken}</Say><Pause length=\"1\"/><Say>#{spoken}</Say></Response>")
  end

  private
    def spoken = "Hey, it's Mack. Your meeting, #{@meeting.title}, started and you are not in it. Go join now."
end
