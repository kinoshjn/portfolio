InspectionMaintenanceItem.destroy_all
InspectionMaintenance.destroy_all
DailyInspectionItem.destroy_all
DailyInspection.destroy_all
FlightRecord.destroy_all
FlightLog.destroy_all
Aircraft.destroy_all
User.destroy_all

# 固定ユーザー作成1
test_user = User.create!(
  user_name: "test_user",
  email: "test@example.com",
  password: "test",
  password_confirmation: "test",
  login_count: 0,
  last_login_date: Date.today,
  avatar_id: 1
)

# 固定ユーザー作成2
guest_user = User.create!(
  user_name: "guest_user",
  email: "guest@example.com",
  password: "guest",
  password_confirmation: "guest",
  login_count: 0,
  last_login_date: Date.today,
  avatar_id: 2
)

# ランダムユーザー作成（8名）
8.times do
  User.create!(
    user_name: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password",
    login_count: rand(0..100),
    last_login_date: Faker::Date.backward(days: 30),
    avatar_id: rand(1..5)
  )
end

# 全ユーザーにAircraft作成
User.ids.each do |user_id|
  Aircraft.create!(
    user_id: user_id,
    dips_registration_number: "JA#{rand(1000..9999)}",
    dips_type: "1",
    dips_model: "1",
    dips_type_approval_number: "1",
    dips_aircraft_registration_category: "1",
    dips_designer_and_manufacturer: Faker::Company.name,
    dips_serial_number: Faker::Alphanumeric.unique.alphanumeric(number: 10).upcase,
    owner_manufacturer: Faker::Company.name,
    model_purchased: Faker::Vehicle.model,
    owner_date_purchased: Faker::Date.backward(days: 365),
    owner_name: Faker::Name.name,
    remote_id_registration_number: "RID-#{rand(10000..99999)}",
    owner_insurance_company: Faker::Company.name,
    owner_policy_number: "POL-#{rand(100000..999999)}",
    owner_insurance_start_date: Faker::Date.backward(days: 365),
    owner_insurance_expiration_date: Faker::Date.forward(days: 365)
  )
end

# 固定ユーザー2名のFlightLog・FlightRecord・DailyInspection・InspectionMaintenanceを作成
[ test_user, guest_user ].each do |user|
  aircraft = user.aircraft

  3.times do
    flight_log = FlightLog.create!(
      aircraft_id: aircraft.id,
      flight_date: Faker::Date.backward(days: 365)
    )

    rand(2..4).times do
      takeoff_hour = rand(6..16)
      flight_hour  = rand(1..3)
      takeoff_time = format("%02d:00:00", takeoff_hour)
      landing_time = format("%02d:00:00", takeoff_hour + flight_hour)
      locations    = [ "神奈川県相模原市中央区田名5835", "神奈川県中郡二宮町", "東京都千代田区" ].sample(2)

      flight_record = FlightRecord.create!(
        flight_log_id: flight_log.id,
        pilot_name: Faker::Name.name,
        takeoff_time: takeoff_time,
        landing_time: landing_time,
        flight_time: rand(30..180),
        total_flight_time: rand(100..300),
        takeoff_location: locations[0],
        landing_location: locations[1],
        flight_summary: Faker::Lorem.sentence,
        has_safety_incident: [ false, true ].sample
      )

      if flight_record.has_safety_incident
        SafetyIncident.create!(
          flight_record_id: flight_record.id,
          details_issues: [ "プロペラガード亀裂", "モーター異音", "バッテリー膨張", "フレーム破損", "通信断絶" ].sample,
          details_date_resolution: Faker::Date.backward(days: 30),
          details_processing: [ "部品交換", "修理", "経過観察", "飛行停止" ].sample,
          details_verifier: Faker::Name.name
        )
      end
    end
  end

  3.times do
    daily_inspection = DailyInspection.create!(
      aircraft_id: aircraft.id,
      inspection_date: Faker::Date.backward(days: 365),
      inspection_location: [ "神奈川県相模原市中央区田名5835", "神奈川県中郡二宮町", "東京都千代田区" ].sample,
      inspector: Faker::Name.name,
      special_notes: Faker::Lorem.sentence
    )

    [
      "機体全般", "プロペラ", "フレーム", "通信系統",
      "推進系統", "電源系統", "自動制御系統", "操作装置", "バッテリー・燃料"
    ].each do |item_name|
      DailyInspectionItem.create!(
        daily_inspection_id: daily_inspection.id,
        item_name: item_name,
        result: [ "1", "2" ].sample,
        note: Faker::Lorem.sentence
      )
    end
  end

  inspection_maintenance = InspectionMaintenance.create!(
    aircraft_id: aircraft.id,
    special_notes: Faker::Lorem.sentence
  )

  3.times do
    InspectionMaintenanceItem.create!(
      inspection_maintenance_id: inspection_maintenance.id,
      item_date: Faker::Date.backward(days: 365),
      item_total_flight_time: rand(0..9999),
      item_maintenance_details: [ "定期点検", "バッテリー交換", "モーター点検", "プロペラ交換" ].sample,
      item_reson_implementation: [ "定期メンテナンス", "不具合発生", "飛行時間超過", "外観異常" ].sample,
      item_location: [ "神奈川県相模原市中央区田名5835", "神奈川県中郡二宮町", "東京都千代田区" ].sample,
      item_organizer: Faker::Name.name,
      item_note: Faker::Lorem.sentence
    )
  end
end
