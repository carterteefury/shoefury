class Spree::AddressEntriesController < Spree::BaseController

  def new
    @address_entry = Spree::AddressEntry.new
    @address = Spree::Address.new
    @country = Spree::Country.find(214)   # United States
  end

  def create

    @address_entry = Spree::AddressEntry.new(params[:address_entry].merge!(:user_id => current_user.id))
    @address_entry.build_address(params[:address].merge!(:country_id => 214))
    @address_entry.save
    if @address_entry.errors.any? || @address_entry.address.errors.any?
      # Error case
      @address = Spree::Address.new(params[:address])
      @country = Spree::Country.find(214)   # United States
      render :new
    else
      redirect_to checkout_path
    end

  end

end
