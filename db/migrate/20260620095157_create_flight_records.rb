class CreateFlightRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :flight_records do |t|

      t.string :pilot_name,null: false
      t.time   :takeoff_time,null: false
      t.time   :landing_time,null: false
      t.time   :flight_time
      t.time   :total_flight_time
      t.string :takeoff_location,null: false
      t.string :landing_location,null: false
      t.string :flight_summary,null: false
      t.boolean :has_safety_incident,null: false
      t.references :flight_log, foreign_key: true

      t.timestamps
    end
  end
end
