class Public::AddressesController < ApplicationController
  def index
    @addresses = current_address.addresses
    @address = Address.new
  end
  
  def create
     @address = address.new(address_params)
    if @address.save
      redirect_to addresss_path
    else
      @addresss = address.all
      render :index
    end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else 
      render :edit
    end
  end
  
  private
  
  def address_params
    params.require(:address).permit(:postal_code, :destination, :name)
  end
end
