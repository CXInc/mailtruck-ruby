class Mailtruck::Email
  attr_accessor :to, :from, :subject

  def initialize(attributes)
    [:to, :from, :subject, :html].each do |key|
      instance_variable_set "@#{key}", attributes[key.to_s]
    end
  end

  def body
    @html
  end

end
