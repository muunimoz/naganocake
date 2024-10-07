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
      render :new
    end
  end

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.includes(:genre)
    end
    @items = all_items.page(params[:page])
    @all_items_count = all_items.count
  end

  def show
  end

  def edit
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
