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
    
    it 'prefecture_idが未選択では購入できない' do
      @order_form.prefecture_id = 1
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Prefecture must be selected")
    end

    it 'cityが空では購入できない' do
      @order_form.city = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("City can't be blank")
    end

    it 'street_addressが空では購入できない' do
      @order_form.street_address = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Street address can't be blank")
    end

    it 'phone_numberが空では購入できない' do
      @order_form.phone_number = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが12桁以上では購入できない' do
      @order_form.phone_number = '123456789012'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Enter 10-11 digits.')
    end

    it 'phone_numberが9桁以下では購入できない' do
      @order_form.phone_number = '123456789'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Enter 10-11 digits.')
    end

    it 'phone_numberに数字以外が含まれる場合は購入できない' do
      @order_form.phone_number = '090-1234-5678'
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