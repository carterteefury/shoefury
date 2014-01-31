class Spree::HeartsController < Spree::BaseController

  def create
    current_user.hearts.create(params[:heart]) if user_signed_in?
  end

end
