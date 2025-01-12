require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品が登録できる時' do
      it '全ての項目が入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が登録できない時' do
      # 商品名
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      # 商品説明
      it '商品説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      # 価格
      it '価格が空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が数値でない場合は登録できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include(
          'Price must be greater than or equal to 300 and less than or equal to 9,999,999'
        )
      end

      it '価格が300未満では登録できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include(
          'Price must be greater than or equal to 300 and less than or equal to 9,999,999'
        )
      end

      it '価格が9,999,999より大きいと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include(
          'Price must be greater than or equal to 300 and less than or equal to 9,999,999'
        )
      end

      # カテゴリー
      it 'カテゴリーが選択されていない場合は登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      # 商品状態
      it '商品の状態が選択されていない場合は登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      # 配送料
      it '配送料の負担が選択されていない場合は登録できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end

      # 発送元の地域
      it '発送元の地域が選択されていない場合は登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      # 発送日
      it '発送日が選択されていない場合は登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end

      # 画像
      it '画像が添付されていない場合は登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      # ユーザーが紐づいていない場合
      it 'ユーザーが紐づいていない場合は登録できない' do
        @item.user = nil # ユーザーを紐づけずにテスト
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist') # エラーメッセージを確認
      end
    end
  end
end
