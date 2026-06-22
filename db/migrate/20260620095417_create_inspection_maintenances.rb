class CreateInspectionMaintenances < ActiveRecord::Migration[7.2]
  def change
    create_table :inspection_maintenances do |t|
      t.text   :special_notes
      t.references :aircraft, foreign_key: true

      t.timestamps
    end
  end
end
