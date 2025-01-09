class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_seller, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(item_id: @item.id)
  end

  def create
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(flattened_order_params)
    @order_address_form.user_id = current_user.id
    @order_address_form.item_id = @item.id
  
    if @order_address_form.valid?
      pay_item
      @order_address_form.save
      redirect_to root_path, notice: "購入が完了しました"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def redirect_if_seller
    @item = Item.find(params[:item_id])
    
    if current_user == @item.user || @item.sold_out?
      redirect_to root_path, alert: "購入できない商品です。"
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def flattened_order_params
    shipping_address = params[:order_address_form][:shipping_address]
    
    # shipping_addressの中身を展開し、他のパラメータと統合
    {
      token: params[:token],
      user_id: current_user.id,
      item_id: params[:item_id],
      postal_code: shipping_address[:postal_code],
      prefecture_id: shipping_address[:prefecture_id],
      city: shipping_address[:city],
      street_address: shipping_address[:street_address],
      building_name: shipping_address[:building_name],
      phone_number: shipping_address[:phone_number]
    }
  end
end