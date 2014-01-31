class AddFreeShippingToBrand < ActiveRecord::Migration
  def change
    add_column :spree_brands, :free_shipping, :boolean, :default=> false
  end
end
