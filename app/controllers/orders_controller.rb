class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    binding.pry # デバッグポイントの設置
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(flattened_order_params)
    @order_address_form.user_id = current_user.id
    @order_address_form.item_id = @item.id

    if @order_address_form.save
      redirect_to root_path, notice: '購入が完了しました！'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def index
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(item_id: @item.id)
  end

  private

  def flattened_order_params
    # ストロングパラメータ設定
    permitted_params = params.require(:order_address_form).permit(:token, shipping_address: [:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number])

    # shipping_addressの内容をフラット化して、必要な値とマージ
    shipping_address_params = permitted_params.delete(:shipping_address)
    permitted_params.merge(shipping_address_params) if shipping_address_params.present?
  end
end
