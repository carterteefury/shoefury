class AddReturnsShippingToBrands < ActiveRecord::Migration
  def change
    add_column :spree_brands, :return_policy, :text
    add_column :spree_brands, :return_days, :integer, :default => 0
    add_column :spree_brands, :shipping_details, :text
  end
end
