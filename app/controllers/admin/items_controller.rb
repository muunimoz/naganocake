class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to adimin_items_path
    else
      @items = Item.all
      render :index
    end
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params.id)
  end

  def edit
    @item = Item.find(params.id)
  end
  
  def update
    @item = Item.find(params.id)
    if @item.update(item_params)
      redirect_to admin_items_path
    else
      render :edit
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active)
  end
  
  def ensure_item
    @item = Item.find(params[:id])
  end
  
end
