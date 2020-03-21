require 'securerandom'

class TextAlertsController < ApplicationController
  get '/' do
    haml :text_alerts
  end

  post '/' do
    phone = PhoneNumber.new(params[:phone])
    @phone = params[:phone]
    @invalid = !phone.valid?

    if phone.valid?
      contact = Contact.find_or_initialize_by(phone: phone.normalized)
      contact.update(confirmation_code: SecureRandom.hex(64))

      TwilioAdapter.new.text(
        contact.phone,
        "Please visit #{ENV['APP_HOST']}/text_alerts/confirm/#{contact.confirmation_code}"
      )
      return haml :text_alert_success
    end

    haml :text_alerts
  end

  get '/confirm/:confirmation_code' do
    if params[:confirmation_code].nil?
      @error = 'No confirmation code' 
      haml :confirm_error
    end
    
    Contact.find_by(confirmation_code: params[:confirmation_code])&.update(confirmed: true)

    haml :confirm_success
  end
end
