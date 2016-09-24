class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name,      null: false
      t.string :middle_name
      t.string :last_name,       null: false
      t.date :date_of_birth
      t.string :gender
      t.string :status,          null: false
      t.integer :location_id,    null: false, index: true
      t.integer :viewed_count,   null: false, default: 0
      t.boolean :is_deleted,     null: false, default: false

      t.timestamps               null: false
    end
  end
end
