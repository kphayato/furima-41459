class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

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
    @items = Item.order(created_at: :desc)
  end

   def show
    @item = Item.find_by(id: params[:id])

   return unless @item.nil?

    @item = Item.new(
     name: 'ダミー商品',
     description: 'これはダミー商品です',
     category_id: 1,
     condition_id: 1,
     shipping_fee_id: 1,
     prefecture_id: 1,    
     shipping_day_id: 1,
     image: nil          
     )
   end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
