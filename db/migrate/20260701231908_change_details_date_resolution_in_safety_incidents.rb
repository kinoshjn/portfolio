class ChangeDetailsDateResolutionInSafetyIncidents < ActiveRecord::Migration[7.2]
  def change
    change_column_null :safety_incidents, :details_date_resolution, true
    change_column_null :safety_incidents, :details_processing, true
    change_column_null :safety_incidents, :details_verifier, true
  end
end
