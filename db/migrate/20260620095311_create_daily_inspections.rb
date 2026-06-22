class CreateDailyInspections < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_inspections do |t|
      t.date   :inspection_date,null: false
      t.string :inspection_location,null: false
      t.string :inspector,null: false
      t.text   :special_notes 
      t.references :aircraft, foreign_key: true

      t.timestamps
    end
  end
end
