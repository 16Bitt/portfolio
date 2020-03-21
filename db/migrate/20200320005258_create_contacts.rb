class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :phone, limit: nil, null: false
      t.string :confirmation_code, limit: nil, null: false
      t.boolean :confirmed, null: false, default: false
      t.timestamps
    end
  end
end
