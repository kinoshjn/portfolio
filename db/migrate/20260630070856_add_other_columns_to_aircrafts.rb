class AddOtherColumnsToAircrafts < ActiveRecord::Migration[7.2]
  def change
    add_column :aircrafts, :dips_model_other, :string
    add_column :aircrafts, :dips_type_approval_number_other, :string
    add_column :aircrafts, :dips_aircraft_registration_category_other, :string
  end
end
