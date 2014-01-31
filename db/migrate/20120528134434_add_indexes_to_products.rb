class AddIndexesToProducts < ActiveRecord::Migration
  def change
    add_index :spree_products, :brand_id
    add_index :spree_products, :hearts_count
    add_index :spree_products, :created_at
    add_index :spree_products, :available_on
  end
end
