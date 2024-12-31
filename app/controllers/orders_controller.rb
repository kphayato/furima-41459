class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])  # item_idを使用するように修正
    @order = Order.new
  end

  def create
    @item = Item.find(params[:item_id])  # item_idを使用するように修正
    @order = Order.new(order_params)
    @order.user = current_user
    @order.item = @item  # ProductからItemに変更
    @order.price = @item.price  # 商品価格を使用

    if @order.save
      ShippingAddress.create(shipping_address_params.merge(order_id: @order.id))
      redirect_to root_path, notice: '購入が完了しました！'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:price, :status)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :prefecture, :city, :house_number, :building_name)
  end
end