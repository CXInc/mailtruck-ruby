require "securerandom"
require "faye"

module Mailtruck

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

  # @return [Mailtruck::Truck] a mailtruck instance
  def self.start
    Mailtruck::Truck.new
  end

end

require "mailtruck/configuration"
require "mailtruck/email"
require "mailtruck/email_address"
require "mailtruck/receiver"
require "mailtruck/truck"
require "mailtruck/version"
