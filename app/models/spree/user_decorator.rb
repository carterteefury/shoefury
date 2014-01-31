Spree::User.class_eval do
  attr_accessible :brand_id
  has_many :hearts

  has_many :address_entries
  has_many :addresses, :through=>:address_entries
  belongs_to :brand

end
