class ItemsController < ApplicationController
  def index
    @items = Item.includes(:image).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end
end