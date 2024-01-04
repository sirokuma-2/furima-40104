FactoryBot.define do
  factory :order_shipping do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { 'テスト市' }
    address { 'テスト1-1-1' }
    building_name { 'テストビル101' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
