class RemoveBrandSocialLinks < ActiveRecord::Migration
  def change
    remove_column :spree_brands, :twitter_url
    remove_column :spree_brands, :facebook_url
    remove_column :spree_brands, :google_url
    remove_column :spree_brands, :pinterest_url
  end
end
