class CreateState < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :name, null: false, limit: nil
      t.string :abbreviation, null: false, limit: nil
    end

    change_table :snapshots do |t|
      t.belongs_to :state, index: true
    end
  end
end
