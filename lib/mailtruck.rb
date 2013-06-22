require "securerandom"
require "faye"

require "mailtruck/configuration"
require "mailtruck/email"
require "mailtruck/email_address"
require "mailtruck/receiver"
require "mailtruck/version"

class Mailtruck

  class Timeout < StandardError; end

  # Configure Mailtruck.
  #
  #     Capybara.configure do |config|
  #       config.timeout = 60
  #     end
  #
  # === Options
  #
  # [email_host = String]    Host where emails will be sent, defaults to mailtruck.bruzilla.com
  # [receiver_url = String]  Mailtruck server, defaults to http://mailtruck.herokuapp.com/faye
  # [timeout = Integer]      Timeout in seconds when waiting for email, defaults to 30
  #
  def self.configure
    yield configuration
  end

  # @return [Mailtruck::Configuration] the Mailtruck configuration.
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Generates an email address that Mailtruck can receive email at.
  #
  # @example
  #   mailtruck = Mailtruck.new
  #   address = mailtruck.email_address
  #
  #   emails = mailtruck.wait_for_emails do
  #     MyApp.send_email_to(address)
  #   end
  #   
  #
  # @yield Block to run that should trigger emails
  # @return [String] an email address
  def email_address
    address = EmailAddress.random
    addresses << address

    address.to_s
  end

  # Waits for emails to be sent to #email_address and returns them.
  #
  # @return [Array<Mailtruck::Email>] the received emails
  def wait_for_emails(&block)
    Receiver.wait_for(addresses, block)
  end

  private

  def addresses
    @addresses ||= []
  end

end
