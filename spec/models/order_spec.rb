require 'rails_helper'

RSpec.describe OrderAddressForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_form = OrderAddressForm.new(
      user_id: @user.id,
      item_id: @item.id,
      postal_code: '123-4567',
      prefecture_id: 3,
      city: 'Test City',
      street_address: '123 Test Street',
      building_name: 'Test Building',
      phone_number: '09012345678',
      token: 'tok_test123'
    )
  end

  context '商品購入ができるとき' do
    it 'user_idとitem_idが存在すれば登録できる' do
      expect(@order_form).to be_valid
    end
    it 'postal_codeとprefecture_idとcityとstreet_addressとphone_numberとtokenが存在すれば登録できる' do
      expect(@order_form).to be_valid
    end
    it 'postal_codeがハイフン含めた7桁の数字なら登録できる' do
      @order_form.postal_code = '123-4567'
      expect(@order_form).to be_valid
    end
    it 'phone_numberが11桁の数字なら登録できる' do
      @order_form.phone_number = '09012345678'
      expect(@order_form).to be_valid
    end
  end

  context '商品購入がうまくいかないとき' do
    it 'user_idが空では保存できない' do
      @order_form.user_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("User can't be blank")
    end
    it 'item_idが空では保存できない' do
      @order_form.item_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Item can't be blank")
    end
    it 'postal_codeが空では保存できない' do
      @order_form.postal_code = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'prefecture_idが空では保存できない' do
      @order_form.prefecture_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Prefecture must be selected')
    end
    it 'cityが空では保存できない' do
      @order_form.city = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("City can't be blank")
    end
    it 'street_addressが空では保存できない' do
      @order_form.street_address = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Street address can't be blank")
    end
    it 'phone_numberが空では保存できない' do
      @order_form.phone_number = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'tokenが空では保存できない' do
      @order_form.token = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Token can't be blank")
    end
    it "prefecture_idがid:1の場合は保存できない" do
      @order_form.prefecture_id = 1
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Prefecture must be selected')
    end
    it 'postal_codeが6桁以下だと登録できない' do
      @order_form.postal_code = '123456'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Postal code is invalid')
    end
    it 'postal_codeが8桁以上だと登録できない' do
      @order_form.postal_code = '12345678'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Postal code is invalid')
    end
    it 'postal_codeがハイフンを含まないと登録できない' do
      @order_form.postal_code = '1234567'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Postal code is invalid')
    end
    it 'phone_numberが10桁未満の数字なら登録できない' do
      @order_form.phone_number = '123456789' # 9桁
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Enter 10-11 digits.')
    end
    it 'phone_numberが12桁以上だと登録できない' do
      @order_form.phone_number = '123456789012' # 12桁
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Enter 10-11 digits.')
    end
  end
end