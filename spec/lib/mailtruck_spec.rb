require_relative '../spec_helper'

describe Mailtruck do

  let(:mailtruck) { Mailtruck.start }

  before(:each) do
    Mailtruck.configure do |config|
      config.email_host = "example.org"
      config.timeout = 0.1
    end
  end

  it "is configurable" do
    Mailtruck.configure do |config|
      config.email_host = "example.com"
    end

    Mailtruck.configuration.email_host.must_equal "example.com"
  end
  
  it "provides email addresses to send emails to" do
    mailtruck.email_address.must_match /.*@example.org/
  end

  it "runs some code and waits for emails to come in" do
    address = mailtruck.email_address

    client = Object.new
    def client.address=(address)
      @address = address
    end
    client.address = address

    def client.subscribe(path)
      yield "to" => @address
    end

    Faye::Client.stubs("new" => client)

    emails = mailtruck.wait_for_emails do
      # code that would trigger an email would go here
    end

    emails.size.must_equal 1
    email = emails.first
    email.to.must_equal(address)
  end

end
