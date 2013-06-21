Thread.abort_on_exception = true

class Mailtruck::Receiver

  def self.wait_for(addresses, block)
    receiver = new(addresses)
    receiver.wait(block)
  end

  def initialize(addresses)
    @addresses = addresses
    @emails = []
  end

  def wait(block)
    Timeout::timeout(Mailtruck.configuration.timeout) do
      EM.run {
        subscribe_to_addresses

        block.call
      }
    end

    @emails
  rescue Timeout::Error => e
    raise Mailtruck::Timeout
  end

  private

  def subscribe_to_addresses
    client.subscribe("/bob") do |message|
      @emails << Mailtruck::Email.new(message)
      check_emails
    end
  end

  def client
    @client ||= Faye::Client.new(Mailtruck.configuration.receiver_url)
  end

  def check_emails
    if @emails.size >= @addresses.size
      EM.stop_event_loop
    end
  end

end
