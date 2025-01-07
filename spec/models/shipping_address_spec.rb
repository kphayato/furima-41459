require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user: @user, item: @item)
    @shipping_address = FactoryBot.build(:shipping_address, order: @order)
  end
