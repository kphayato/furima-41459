class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(item_id: @item.id)
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address_form = OrderAddressForm.new(flattened_order_params)
    @order_address_form.user_id = current_user.id
    @order_address_form.item_id = @item.id
  
    # デバッグ用のログ
    Rails.logger.debug "PARAMS: #{params.inspect}"
    Rails.logger.debug "OrderAddressForm#save called with: #{self.inspect}"
  
    # バリデーション確認
    if @order_address_form.valid?
      Rails.logger.debug "VALIDATION PASSED"
      pay_item
      if @order_address_form.save
        Rails.logger.debug "SAVE PASSED"
        redirect_to root_path, notice: '購入が完了しました！'
      else
        Rails.logger.debug "SAVE FAILED: #{@order_address_form.errors.full_messages}"
        render :index, status: :unprocessable_entity
      end
    else
      Rails.logger.debug "VALIDATION FAILED: #{@order_address_form.errors.full_messages}"
      render :index, status: :unprocessable_entity
    end
  end

  private

  def pay_item
    Payjp.api_key = "sk_test_a84f69bf77ecf501054cfc97"
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: flattened_order_params[:token],
      currency: 'jpy'
    )
    Rails.logger.debug "PAY.JP RESPONSE: #{charge.inspect}"
  rescue Payjp::PayjpError => e
    Rails.logger.error "PAY.JP ERROR: #{e.message}"
    raise
  end

  def flattened_order_params
    params.require(:order_address_form).permit(
      :token,
      shipping_address: [:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number]
    ).tap do |permitted|
      shipping_address = permitted.delete(:shipping_address) || {}
      permitted.merge!(shipping_address)
      permitted[:token] = params[:token] if params[:token].present?
    end
  end
end