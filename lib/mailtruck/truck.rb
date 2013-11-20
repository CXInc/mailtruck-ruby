class Mailtruck::Truck

  # Generates an email address that Mailtruck can receive email at.
  #
  # @example
  #   mailtruck = Mailtruck.start
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
    address = Mailtruck::EmailAddress.random
    addresses << address

    address.to_s
  end

  # Waits for emails to be sent to #email_address and returns them.
  #
  # @return [Array<Mailtruck::Email>] the received emails
  def wait_for_emails(&block)
    Mailtruck::Receiver.wait_for(addresses, block)
  end

  private

  def addresses
    @addresses ||= []
  end

end
