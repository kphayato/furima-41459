require 'rails_helper'

RSpec.describe OrderAddressForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_address_form, user_id: @user.id, item_id: @item.id)
  end

  context '商品購入ができるとき' do
    it 'すべての情報が正しく入力されていれば購入できる' do
      expect(@order_form).to be_valid
    end

    it 'building_nameが空でも購入できる' do
      @order_form.building_name = ''
      expect(@order_form).to be_valid
    end
  end

  context '商品購入ができないとき' do
    it 'user_idが空では購入できない' do
      @order_form.user_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では購入できない' do
      @order_form.item_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Item can't be blank")
    end

    it 'postal_codeが空では購入できない' do
      @order_form.postal_code = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeがハイフンを含まない形式では購入できない' do
      @order_form.postal_code = '1234567'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-).')
    end

    it 'phone_numberが12桁以上では購入できない' do
      @order_form.phone_number = '123456789012'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Enter 10-11 digits.')
    end

    it 'tokenが空では購入できない' do
      @order_form.token = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Token can't be blank")
    end
  end
end