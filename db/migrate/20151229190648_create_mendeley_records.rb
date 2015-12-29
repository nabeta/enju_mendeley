class CreateMendeleyRecords < ActiveRecord::Migration
  def change
    create_table :mendeley_records do |t|
      t.string :body
      t.integer :manifestation_id

      t.timestamps null: false
    end
    add_index :mendeley_records, :manifestation_id
  end
end
