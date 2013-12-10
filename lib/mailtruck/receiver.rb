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
      Thread.new do
        EM.run {
          subscribe_to_addresses

          block.call
        }
      end
    end

    while(missing_emails) do
      sleep 0.1
    end

    @emails
  rescue Timeout::Error => e
    raise Mailtruck::Timeout
  end

  private

  def subscribe_to_addresses
    @addresses.each do |address|
      channel = "/" + address.prefix

      client.subscribe(channel) do |message|
        @emails << Mailtruck::Email.new(message)
      end
    end
  end

  def client
    @client ||= Faye::Client.new(Mailtruck.configuration.receiver_url)
  end

  def missing_emails
    @emails.size < @addresses.size
  end

end
