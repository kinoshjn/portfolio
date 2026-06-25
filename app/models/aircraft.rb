class Aircraft < ApplicationRecord
  validates :dips_registration_number, presence: true
  validates :dips_type, presence: true
  validates :dips_model, presence: true
  validates :dips_type_approval_number, presence: true
  validates :dips_aircraft_registration_category, presence: true
  validates :dips_designer_and_manufacturer, presence: true
  validates :dips_serial_number, presence: true
  validates :owner_manufacturer, presence: true
  validates :model_purchased, presence: true
  validates :owner_name, presence: true
  validates :remote_id_registration_number, presence: true

  belongs_to :user

  has_many :flight_logs, dependent: :destroy
  has_many :daily_inspections, dependent: :destroy
  has_one :inspection_maintenance, dependent: :destroy
end
