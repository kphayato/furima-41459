class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, ]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が出品されました。'
    else
      render :new 
    end
  end

   def index
     @items = Item.all
   end

   def show
    @item = Item.find_by(id: params[:id]) # find_byを使ってnilを返すようにする
    if @item.nil?
      redirect_to root_path, alert: "商品が見つかりませんでした"
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
