class AddPinterestUrl < ActiveRecord::Migration

  def change
    add_column :spree_brands, :pinterest_url, :string
  end

end
