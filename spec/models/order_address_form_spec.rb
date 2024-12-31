require 'rails_helper'

RSpec.describe OrderAddressForm, type: :model do
  before do
    # 必要な関連データを作成
    @category = Category.create!(name: 'Category 1')
    @condition = Condition.create!(name: 'New')
    @shipping_fee = ShippingFee.create!(name: 'Free')
    @shipping_day = ShippingDay.create!(name: 'Same day')

    # テスト用のユーザーを作成
    @user = User.create!(
      nickname: 'testuser',
      email: 'test@example.com',
      password: 'password1',
      first_name: '太郎',
      last_name: '山田',
      first_name_kana: 'タロウ',
      last_name_kana: 'ヤマダ',
      birth_date: '2000-01-01'
    )

    # ダミー画像を作成（spec/fixtures/files/test_image.pngを使用）
    image = Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')
    
    # テスト用の商品を作成（必須項目をすべて設定）
    @item = Item.create!(
      name: 'Test Item',
      description: 'Test Description',
      price: 1000,                          # 価格（300以上9999999以下）
      category_id: @category.id,            # 作成したカテゴリーIDを設定
      condition_id: @condition.id,          # 作成した状態IDを設定
      shipping_fee_id: @shipping_fee.id,    # 作成した送料負担IDを設定
      prefecture_id: 3,                     # 都道府県（仮に3を設定）
      shipping_day_id: @shipping_day.id,    # 作成した発送日IDを設定
      user_id: @user.id,
      image: fixture_file_upload(image, 'image/png')  # ダミー画像を設定
    )
  end

  describe '#save' do
    it 'OrderとAddressを正しく保存すること' do
      order_address = OrderAddressForm.new(
        user_id: @user.id,       # 事前に作成したユーザーのIDを使用
        item_id: @item.id,       # 事前に作成した商品のIDを使用
        postal_code: '123-4567',
        prefecture_id: 3,
        city: 'Tokyo',
        street_address: 'Shibuya 1-1-1',
        building_name: 'Sky Tower',
        phone_number: '09012345678',
        token: 'sample_token'
      )

      # 保存前のレコード数を確認
      expect { order_address.save }.to change(Order, :count).by(1)
                                             .and change(Address, :count).by(1)
    end
  end
end