class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @product = Product.find(params[:product_id])
    @order = Order.new
  end

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(order_params)
    @order.user = current_user
    @order.product = @product
    @order.price = @product.price

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