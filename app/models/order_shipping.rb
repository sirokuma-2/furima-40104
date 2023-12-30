class OrderShipping
  include ActiveModel::Model
  attr_accessor  :item_id, :user_id,:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

   with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include a hyphen(-)" }
    validates :prefecture_id, numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 47,
      message:"must be between 1 and 47"
    }
    validates :city
    validates :address
    validates :token
    validates :phone_number, format: { with: /\A\d{10}\z|\A\d{11}\z/ }
   end


  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Shipping.create(postal_code: postal_code,
                    prefecture_id: prefecture_id,
                    city: city, address: address,
                    building_name: building_name,
                    phone_number:phone_number,
                    order_id: order.id)
  end
end
