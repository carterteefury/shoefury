class AddHeartsCounterToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :hearts_count, :integer, :default=>0
  end
end
