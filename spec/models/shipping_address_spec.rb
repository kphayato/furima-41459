require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user: @user, item: @item)
    @shipping_address = FactoryBot.build(:shipping_address, order: @order)
  end

  context '注文が保存できる場合' do
    it '全ての項目が適切に入力されていれば保存できる' do
      expect(@order).to be_valid
    end
  end

  context '注文が保存できない場合' do
    it '配送先住所が無効だと保存できない' do
      @shipping_address.street_address = "12345"  # 不正な住所
      expect(@shipping_address).to_not be_valid
    end

    it '郵便番号が「3桁ハイフン4桁」の形式でないと保存できない' do
      @shipping_address.postal_code = '1234-5678'  # 不正な形式
      expect(@shipping_address).to_not be_valid
    end

    it '電話番号が10桁以上11桁以内でないと保存できない' do
      @shipping_address.phone_number = '090123456'  # 9桁の番号
      expect(@shipping_address).to_not be_valid
    end

    it '電話番号が必須である' do
      @shipping_address.phone_number = nil
      expect(@shipping_address).to_not be_valid
    end

    it '配送先情報が不足していると保存できない' do
      @shipping_address.city = nil
      expect(@shipping_address).to_not be_valid
    end

    it '郵便番号が必須である' do
      @shipping_address.postal_code = nil
      expect(@shipping_address).to_not be_valid
    end

    it 'itemが関連付けられていないと保存できない' do
      @order.item = nil
      expect(@order).to_not be_valid
    end

    it 'userが関連付けられていないと保存できない' do
      @order.user = nil
      expect(@order).to_not be_valid
    end
  end
end