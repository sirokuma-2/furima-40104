require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    @order_shipping = FactoryBot.build(:order_shipping)
  end

  describe '購入' do
    context '購入できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@order_shipping).to be_valid
      end
      it 'building_nameが空でも登録できる' do
        @order_shipping.building_name = ''
        expect(@order_shipping).to be_valid
      end
    end
    context '購入できないとき' do
      it 'item_idが空では登録できない' do
        @order_shipping.item_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
      it 'user_idが空では登録できない' do
        @order_shipping.user_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'postal_codeが空では登録できない' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeは-を含まないと登録できない' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Include a hyphen(-)')
      end
      it 'prefecture_idが空では登録できない' do
        @order_shipping.prefecture_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが0では登録できない' do
        @order_shipping.prefecture_id = 0
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Prefecture must be between 1 and 47')
      end
      it 'prefecture_idが48以上では登録できない' do
        @order_shipping.prefecture_id = 49
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Prefecture must be between 1 and 47')
      end
      it 'cityが空では登録できない' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では登録できない' do
        @order_shipping.address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberは空では登録できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは9桁以下では登録できない' do
        @order_shipping.phone_number = Faker::Number.between(from: 0, to: 9_999_999).to_s
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberは12桁以上では登録できない' do
        @order_shipping.phone_number = Faker::Number.between(from: 100_000_000_000, to: 100_000_000_000_000).to_s
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenは空では登録できない' do
        @order_shipping.token = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
