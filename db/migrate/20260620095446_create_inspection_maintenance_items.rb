class CreateInspectionMaintenanceItems < ActiveRecord::Migration[7.2]
  def change
    create_table :inspection_maintenance_items do |t|
      t.date   :item_date,null: false
      t.time   :item_total_flight_time
      t.string :item_maintenance_details,null: false
      t.string :item_reson_implementation,null: false
      t.string :item_location,null: false
      t.string :item_organizer,null: false
      t.string :item_note
      t.references :inspection_maintenance, foreign_key: true

      t.timestamps
    end
  end
end
