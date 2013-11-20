class Mailtruck::EmailAddress

  attr_reader :prefix

  def self.random
    new(random_string)
  end

  def initialize(prefix)
    @prefix = prefix
  end

  def to_s
    "#{@prefix}@#{Mailtruck.configuration.email_host}"
  end

  private

  def self.random_string
    SecureRandom.urlsafe_base64
  end
end
