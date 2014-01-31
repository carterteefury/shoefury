class AddBrandToSpreeProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :brand_id, :integer
  end
end
