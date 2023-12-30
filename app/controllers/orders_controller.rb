class OrdersController < ApplicationController
  before_action :find_item

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_shipping = OrderShipping.new
  end

  def create
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end
end
