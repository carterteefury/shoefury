class AddBrandToSpreeUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :brand_id, :integer
  end
end
