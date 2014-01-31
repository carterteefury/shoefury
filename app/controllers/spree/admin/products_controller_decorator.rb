Spree::Admin::ProductsController.class_eval do

  def import
    if request.method == "POST"
      @messages = []
      @products = []
      require 'csv'
      file = params[:import_products][:csv]
      products = CSV.read(file.tempfile.path)
      products.shift
      products.each_with_index do |product,index|
        product.row[0].blank? ? import_variant(row,index+2) : import_product(row,index+2)
      end
      respond_with(@products) do |format|
        format.html
        format.json { render :json => json_data }
      end
    end
  end

  private
  def import_product(row,index)
    product = Product.new
    product.name = row[1]
    product.brand_id = Spree::Brand.find_by_name(row[2]).id
    product.prototype_id = Spree::Prototype.find_by_name(row[3]).id
    product.available_on = row[4].to_date
    product.description = row[5]
    product.on_hand = row[6].to_i
    product.shipping_category_id = Spree::ShippingCategory.find_by_name(row[7]).id
    product.tax_category_id = Spree::TaxCategory.find_by_name(row[8]).id
    product.meta_keywords = row[9]
    product.meta_description = row[10]



  rescue

  end

  def import_variant(row,index)
  end

end
