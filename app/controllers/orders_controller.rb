class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(flattened_order_params)
    @order_address_form.user_id = current_user.id
    @order_address_form.item_id = @item.id

    # バリデーションを確認
    if @order_address_form.valid?
      if @order_address_form.save
        redirect_to root_path, notice: '購入が完了しました！'
      else
        # 保存に失敗した場合
        render :index, status: :unprocessable_entity  
      end
    else
      # バリデーションエラーがある場合
      @order_address_form.prefecture_id = params.dig(:order_address_form, :shipping_address, :prefecture_id) || ''
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