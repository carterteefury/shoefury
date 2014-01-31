class AddDefaultAddressToAddressEntries < ActiveRecord::Migration
  def change
    add_column :spree_address_entries, :primary_address, :boolean, :default => false
  end
end
