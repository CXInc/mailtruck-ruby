require "securerandom"
require "faye"

require "mailtruck/configuration"
require "mailtruck/email"
require "mailtruck/email_address"
require "mailtruck/receiver"
require "mailtruck/version"

class Mailtruck

  class Timeout < StandardError; end

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def email_address
    address = EmailAddress.random
    addresses << address

    address.to_s
  end

  def wait_for_emails(&block)
    Receiver.wait_for(addresses, block)
  end

  private

  def addresses
    @addresses ||= []
  end

end
