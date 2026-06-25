class CreateAircrafts < ActiveRecord::Migration[7.2]
  def change
    create_table :aircrafts do |t|
      t.string :dips_registration_number, null: false
      t.string :dips_type, null: false
      t.string :dips_model, null: false
      t.string :dips_type_approval_number, null: false
      t.string :dips_aircraft_registration_category, null: false
      t.string :dips_designer_and_manufacturer, null: false
      t.string :dips_serial_number, null: false
      t.string :owner_manufacturer, null: false
      t.string :model_purchased, null: false
      t.date   :owner_date_purchased
      t.string :owner_name, null: false
      t.string :remote_id_registration_number, null: false
      t.string :owner_insurance_company
      t.string :owner_policy_number
      t.date   :owner_insurance_start_date
      t.date   :owner_insurance_expiration_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
