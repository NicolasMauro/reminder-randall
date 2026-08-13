require "net/http"
require "json"

module Http
  module_function

  def get(url) = Net::HTTP.get_response(URI(url)).body

  def post_json(url, payload, headers = {})
    post(url, payload.to_json, { "Content-Type" => "application/json" }.merge(headers))
  end

  def post_form(url, form, basic_auth: nil)
    uri = URI(url)
    req = Net::HTTP::Post.new(uri)
    req.set_form_data(form)
    req.basic_auth(*basic_auth) if basic_auth
    run(uri, req)
  end

  def post(url, body, headers)
    uri = URI(url)
    req = Net::HTTP::Post.new(uri, headers)
    req.body = body
    run(uri, req)
  end

  def run(uri, req)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") { |http| http.request(req) }
  end
end
