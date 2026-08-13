module Twilio
  module_function

  def message(from:, to:, body:) = post("Messages.json", From: from, To: to, Body: body)
  def call(from:, to:, twiml:)    = post("Calls.json", From: from, To: to, Twiml: twiml)

  def post(resource, **form)
    sid = ENV.fetch("TWILIO_ACCOUNT_SID")
    Http.post_form("https://api.twilio.com/2010-04-01/Accounts/#{sid}/#{resource}",
                   form.transform_keys(&:to_s), basic_auth: [ sid, ENV.fetch("TWILIO_AUTH_TOKEN") ])
  end
end
