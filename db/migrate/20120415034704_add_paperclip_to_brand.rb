class AddPaperclipToBrand < ActiveRecord::Migration
  def self.up
    add_column :spree_brands, :logo_file_name, :string
    add_column :spree_brands, :logo_content_type, :string
    add_column :spree_brands, :logo_file_size, :integer
    add_column :spree_brands, :logo_updated_at, :datetime
    add_column :spree_brands, :background_file_name, :string
    add_column :spree_brands, :background_content_type, :string
    add_column :spree_brands, :background_file_size, :integer
    add_column :spree_brands, :background_updated_at, :datetime
    add_column :spree_brands, :sizing_chart_file_name, :string
    add_column :spree_brands, :sizing_chart_content_type, :string
    add_column :spree_brands, :sizing_chart_file_size, :integer
    add_column :spree_brands, :sizing_chart_updated_at, :datetime
  end

  def self.down
    remove_column :spree_brands, :logo_file_name
    remove_column :spree_brands, :logo_content_type
    remove_column :spree_brands, :logo_file_size
    remove_column :spree_brands, :logo_updated_at
    remove_column :spree_brands, :background_file_name
    remove_column :spree_brands, :background_content_type
    remove_column :spree_brands, :background_file_size
    remove_column :spree_brands, :background_updated_at
    remove_column :spree_brands, :sizing_chart_file_name
    remove_column :spree_brands, :sizing_chart_content_type
    remove_column :spree_brands, :sizing_chart_file_size
    remove_column :spree_brands, :sizing_chart_updated_at
  end
end
