class Contact < ActiveRecord::Base
  scope :confirmed, ->{ where(confirmed: true) }
end
