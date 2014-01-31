class Spree::Heart < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :value

  belongs_to :product, :counter_cache=>true
  belongs_to :user

  validates :product_id, :user_id, presence:true
  validates :product_id, uniqueness: {scope: :user_id}
end
