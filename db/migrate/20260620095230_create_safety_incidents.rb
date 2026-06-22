class CreateSafetyIncidents < ActiveRecord::Migration[7.2]
  def change
    create_table :safety_incidents do |t|
      t.string :details_issues,null: false
      t.date   :details_date_resolution,null: false
      t.string :details_processing,null: false
      t.string :details_verifier,null: false
      t.references :flight_record, foreign_key: true

      t.timestamps
    end
  end
end
