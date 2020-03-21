require 'twilio-ruby'

class TwilioAdapter
  def initialize
    @sid = ENV['TWILIO_SID']
    @token = ENV['TWILIO_TOKEN']
    @from = ENV['TWILIO_NUMBER']
  end

  def text(to, msg)
    client.messages.create(
      to: to,
      from: @from,
      body: msg
    )
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(@sid, @token)
  end
end
