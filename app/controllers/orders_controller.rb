class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping = OrderShipping.new
    return unless current_user.id == @item.user_id || Order.exists?(item_id: @item.id)

    redirect_to root_path
  end

  def create
    @order_shipping = OrderShipping.new(order_params)

    if current_user == @item.user
      redirect_to root_path
    elsif @order_shipping.valid? && @order_shipping.save
      pay_item
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_shipping).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building_name,
      :phone_number
    ).merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end
end
