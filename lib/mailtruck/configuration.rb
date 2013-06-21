class Mailtruck::Configuration
  attr_accessor :email_host, :receiver_url, :timeout

  def initialize(attributes = {})
    @email_host = attributes[:email_host] || "mailtruck.bruzilla.com"
    @receiver_url = attributes[:receiver_url] || "http://mailtruck.herokuapp.com/faye"
    @timeout = attributes[:timeout] || 30
  end
end
