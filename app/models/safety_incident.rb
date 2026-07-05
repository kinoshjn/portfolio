class SafetyIncident < ApplicationRecord
  belongs_to :flight_record
  #  validates :details_issues, :details_date_resolution, :details_processing, :details_verifier, presence: true
  validates :details_issues, presence: true
end
