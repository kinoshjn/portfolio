User.destroy_all
Aircraft.destroy_all

10.times do
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

