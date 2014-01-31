class CreateSpreeHearts < ActiveRecord::Migration
  def change
    create_table :spree_hearts do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
    add_index :spree_hearts, [:product_id,:user_id], unique: true
  end
end
