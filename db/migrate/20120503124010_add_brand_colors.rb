class AddBrandColors < ActiveRecord::Migration
  
  def change
    add_column :spree_brands, :background_color, :string
    add_column :spree_brands, :primary_text_color, :string
    add_column :spree_brands, :secondary_text_color, :string
    add_column :spree_brands, :link_color, :string
    add_column :spree_brands, :dark_color_scheme, :boolean
  end

end
