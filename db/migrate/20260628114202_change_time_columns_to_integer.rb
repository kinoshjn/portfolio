class ChangeTimeColumnsToInteger < ActiveRecord::Migration[7.2]
  def change
    change_column :flight_records, :flight_time, :integer, using: 'NULL'
    change_column :flight_records, :total_flight_time, :integer, using: 'NULL'
    change_column :inspection_maintenance_items, :item_total_flight_time, :integer, using: 'NULL'
  end
end
