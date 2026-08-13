class Sender::Imessage < Sender::Base
  # Blue-bubble iMessage from the cloud via LoopMessage (works on Windows/Linux hosts).
  def deliver(mode = :blast)
    Http.post_json("https://server.loopmessage.com/api/v1/message/send/",
      { recipient: user.phone, text: body(mode), sender_name: ENV["LOOPMESSAGE_SENDER"] },
      "Authorization" => ENV.fetch("LOOPMESSAGE_AUTH_KEY"),
      "Loop-Secret-Key" => ENV.fetch("LOOPMESSAGE_SECRET_KEY"))
  end
end
