DailyInspection.destroy_all
FlightRecord.destroy_all
FlightLog.destroy_all
Aircraft.destroy_all
User.destroy_all

# 固定ユーザー作成
fixed_user = User.create!(
  user_name: "test_user",
  email: "test@example.com",
  password: "test",
  password_confirmation: "test",
  login_count: 0,
  last_login_date: Date.today,
  avatar_id: 1
)

# ランダムユーザー作成（9名）
9.times do
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

user_ids = User.ids

user_ids.each do |user_id|
  Aircraft.create!(
    user_id: user_id,
    dips_registration_number: "JA#{rand(1000..9999)}",
    dips_type: Faker::Vehicle.make,
    dips_model: Faker::Vehicle.model,
    dips_type_approval_number: "TA-#{rand(10000..99999)}",
    dips_aircraft_registration_category: ["第一種", "第二種", "第三種"].sample,
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

# 固定ユーザーのflight_log 3件作成
fixed_aircraft = fixed_user.aircraft

3.times do
  flight_log = FlightLog.create!(
    aircraft_id: fixed_aircraft.id,
    flight_date: Faker::Date.backward(days: 365)
  )

  takeoff_hour = rand(6..16)
  flight_hour = rand(1..3)
  takeoff_time = format("%02d:00:00", takeoff_hour)
  landing_time = format("%02d:00:00", takeoff_hour + flight_hour)
  flight_time  = format("00:%02d:00", flight_hour * 60)

  locations = ["神奈川県相模原市中央区田名5835", "神奈川県中郡二宮町", "東京都千代田区"].sample(2)

  FlightRecord.create!(
    flight_log_id: flight_log.id,
    pilot_name: Faker::Name.name,
    takeoff_time: takeoff_time,
    landing_time: landing_time,
    flight_time: flight_time,
    takeoff_location: locations[0],
    landing_location: locations[1],
    flight_summary: Faker::Lorem.sentence,
    has_safety_incident: false
  )
end

# fixed_aircraftの作成以降に追加
3.times do
  DailyInspection.create!(
    aircraft_id: fixed_aircraft.id,
    inspection_date: Faker::Date.backward(days: 365),
    inspection_location: ["神奈川県相模原市中央区田名5835", "神奈川県中郡二宮町", "東京都千代田区"].sample,
    inspector: Faker::Name.name,
    special_notes: Faker::Lorem.sentence
  )
end