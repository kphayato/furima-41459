class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_seller, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address_form = OrderAddressForm.new(item_id: @item.id)
  end

  def create
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
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

  # @item を設定するメソッド
  def set_item
    @item = Item.find(params[:item_id])
  end

  # 出品者または売却済み商品の場合はトップページにリダイレクト
  def redirect_if_seller
    if current_user == @item.user || @item.sold_out?
      redirect_to root_path, alert: "購入できない商品です。"
    end
  end

  # 決済処理
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def flattened_order_params
    shipping_params = params.require(:order_address_form).require(:shipping_address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :street_address,
      :building_name,
      :phone_number
    )
    shipping_params.merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end
end