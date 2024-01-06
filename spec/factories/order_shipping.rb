FactoryBot.define do
  factory :order_shipping do
    postal_code { "#{Faker::Number.between(from: 100, to: 999)}-#{Faker::Number.between(from: 1000, to: 9999)}" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building_name { Faker::Address.building_number }
    phone_number { "0#{Faker::Number.between(from: 100_000_000, to: 9_999_999_999)}" }
    token { 'tok_e4942a5e6aa2bfb3b37463dfad46' }
  end
end
