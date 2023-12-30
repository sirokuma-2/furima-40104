class OrdersController < ApplicationController
  before_action :find_item

  def index
    @order_shipping = OrderShipping.new
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end
end
