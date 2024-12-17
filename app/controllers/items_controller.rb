class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

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
      @item = Item.find(params[:id])
   end

   def edit
    @item = Item.find(params[:id])
    redirect_to root_path unless current_user == @item.user
   end

   def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to root_path
   end


  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
