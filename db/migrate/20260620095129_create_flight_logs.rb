class CreateFlightLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :flight_logs do |t|
      t.date :flight_date, null: false
      t.references :aircraft, foreign_key: true

      t.timestamps
    end
  end
end
