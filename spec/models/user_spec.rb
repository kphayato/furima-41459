require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = User.new(
        nickname: 'TestUser',
        email: 'test@example.com',
        password: 'password1',
        password_confirmation: 'password1',
        last_name: '山田',
        first_name: '太郎',
        last_name_kana: 'ヤマダ',
        first_name_kana: 'タロウ',
        birth_date: '2000-01-01'
      )
    end

    it 'ニックネームが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'パスワードに英字と数字の両方が含まれないと登録できない' do
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
    end

    it '全角の名字が空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it '全角の名前が空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it '全角カナの名字が空では登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it '全角カナの名前が空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it '生年月日が空では登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end