class CreateSnapshots < ActiveRecord::Migration[6.0]
  def change
    create_table :snapshots do |t|
      t.integer :case_count, null: false, default: 0
      t.timestamps
    end
  end
end
