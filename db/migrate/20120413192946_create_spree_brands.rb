class CreateSpreeBrands < ActiveRecord::Migration
  def change
    create_table :spree_brands do |t|
      t.string :name

      t.timestamps
    end
  end
end
