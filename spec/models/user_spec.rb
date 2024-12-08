require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '新規登録ができる場合' do
      it '全ての情報が正しく入力されていれば登録できる' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context '新規登録ができない場合' do
      it 'nicknameが空では登録できない' do
        user = FactoryBot.build(:user, nickname: nil)
        user.valid?
        expect(user.errors.full_messages).to include("Nicknameを入力してください")
      end

      it 'emailが空では登録できない' do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors.full_messages).to include("Emailを入力してください")
      end

      # 他のバリデーションに関するテストを追加
    end
  end
end