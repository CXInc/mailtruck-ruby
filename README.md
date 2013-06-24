# Mailtruck

There are occasions when it's necessary to receive an email and follow a link
as part of an integration test, for instance email confirmation. When the
email is being sent from the app where the test is running, there are some
nice options (see Similar Projects below) to aid in integration testing. But
if the email is being sent from another service you don't control, it's not as
easy to hook into the process. Mailtruck aims to make that doable.

## Installation

Add this line to your application's Gemfile:

    gem 'mailtruck'

And then run:

    $ bundle

Or install it yourself with:

    $ gem install mailtruck

## Usage

### Quick Start 

```ruby
mailtruck = Mailtruck.new

# an email address where Mailtruck can pick up your email
address = mailtruck.email_address
# => somerandomstring@mailtruck.bruzilla.com

# Mailtruck will wait until you receive
emails = mailtruck.wait_for_emails do
  # YOUR CODE TO SEND EMAIL TO address HERE
end

emails.each do |email|
  puts "Email to, from, subject, body: #{email.to}, #{email.from}, " +
       "#{email.subject}, #{email.body}"
end
```

### Configuration

```ruby
Mailtruck.configure do |config|
  # host where emails will be sent, defaults to mailtruck.bruzilla.com
  config.email_host = "example.com"

  # Mailtruck server, defaults to http://mailtruck.herokuapp.com/faye
  config.receiver_url = "http://example.com/faye"

  # timeout in seconds when waiting for email, defaults to 30
  config.timeout = 60
end
```

### Multiple emails

When multiple emails are being sent, ask for the number of emails needed and
it will wait for that number of emails.

```ruby
mailtruck = Mailtruck.new

addresses = [mailtruck.email_address, mailtruck.email_address]

emails = mailtruck.wait_for_emails do
  # YOUR CODE TO SEND EMAIL TO EACH ADDRESS IN addresses HERE
end
```

### Capybara

When running Mailtruck in Capybara tests, the usual helper methods are
available:

```ruby
emails = mailtruck.wait_for_emails do
  # YOUR CODE TO SEND EMAIL TO address HERE
end

emails.first.body.should have_content("Way to go, champ!")
```

## How does it work?

When `wait_for_emails` is called, Mailtruck connects to a service that will
listen for email being received at the addresses it has provided with the
`email_address` method. The code block passed to `wait_for_emails` is then
run, and assuming it sends emails to the provided addresses, they will get
posted back to the Mailtruck back end service. They messages are then passed
to the listener and returned as instances of `Mailtruck::Email`.

## Security

There is none currently, so **consider any emails you send through Mailtruck
public**. This may not be an issue if you're just sending dummy test data and
content that's not sensitive, but if there's anything in your emails that
you want to keep private then don't use Mailtruck.

Making Mailtruck more secure is definitely a future possibility.

## Tests

Simply run:

    rake test

## Similar Projects

- [CapybaraEmail](https://github.com/dockyard/capybara-email)
- [Letter Opener](https://github.com/ryanb/letter_opener)
- [MailCatcher](http://mailcatcher.me/)
- [Mailtrap](http://mailtrap.io/)
- [MailView](https://github.com/37signals/mail_view)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes, with tests (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
