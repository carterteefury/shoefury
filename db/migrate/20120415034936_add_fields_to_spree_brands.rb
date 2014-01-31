class AddFieldsToSpreeBrands < ActiveRecord::Migration
  def change
    add_column :spree_brands, :twitter_url, :string
    add_column :spree_brands, :facebook_url, :string
    add_column :spree_brands, :google_url, :string
    add_column :spree_brands, :about, :text

  end
end
