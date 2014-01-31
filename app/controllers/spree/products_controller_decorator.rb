Spree::ProductsController.class_eval do
  before_filter :check_login, :only=>:show
  before_filter :load_products, :only =>[:show,:index]

  def show
    @brand_products = Spree::Product.active.where(:brand_id => @product.brand_id) 
    @brand_products = @brand_products.on_hand unless Spree::Config[:show_zero_stock_products]
    session[:last_product_path] = request.url
  end
  
  def index
    if params[:page].blank?
      if !params[:keywords].blank?
        session[:last_product_path] = root_url + "?keywords=" + params[:keywords]
      else    
        session[:last_product_path] = root_url
      end
    end
    logger.info "HOME: " + session[:last_product_path]
  end

  protected

  private
  def check_login
    if !current_user
      session[:clicks] ? session[:clicks]= session[:clicks]+1 : session[:clicks]=1
      if session[:clicks] > 3
        store_location
        redirect_to spree.login_path and return
      end
    end
  end

  def load_products
    params[:per_page] ||= 10
    @page = params[:page]||1
    @list = params[:list]
    @hearts = current_user.hearts if user_signed_in?
    @searcher = Spree::Search::BrandSearch.new(params)
    @products = @searcher.retrieve_products
    @num_pages = @products.num_pages
  end


end
