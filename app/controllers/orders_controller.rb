class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_seller, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(item_id: @item.id)
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(flattened_order_params)
    @order_address_form.user_id = current_user.id
    @order_address_form.item_id = @item.id
  
    if @order_address_form.valid?
      pay_item
      @order_address_form.save
      redirect_to root_path, notice: "購入が完了しました"
    else
      @item = Item.find(params[:item_id]) # 再度アイテム情報を取得
      render :index, status: :unprocessable_entity
    end
  end

  private

  def redirect_if_seller
    @item = Item.find(params[:item_id])
    if current_user == @item.user
      redirect_to root_path, alert: "自身が出品した商品の購入ページにはアクセスできません。"
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
    params.require(:order_address_form).permit(
      :token,
      :postal_code,
      :prefecture_id,
      :city,
      :street_address,
      :building_name,
      :phone_number
    )
  end
end