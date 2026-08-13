class Sender::Whatsapp < Sender::Base
  def deliver(mode = :blast)
    Twilio.message(from: "whatsapp:#{ENV.fetch("TWILIO_WHATSAPP_FROM")}",
                   to: "whatsapp:#{user.phone}", body: body(mode))
  end
end
