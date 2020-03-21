class PhoneNumber
  def initialize(phone)
    @phone = phone
  end

  def valid?
    @phone.to_s =~ /\(?\d\d\d\)?\-?\d\d\d\-?\d\d\d\d/
  end

  def normalized
    @phone.to_s.gsub(/[\-\s\(\)]/, '')
  end
end
