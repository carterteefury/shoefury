class CreateAddressEntries < ActiveRecord::Migration
  def change
    create_table :spree_address_entries do |t|
      t.string :name
      t.integer :user_id
      t.integer :address_id

      t.timestamps
    end
  end
end
