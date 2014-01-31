Spree::Product.class_eval do
  attr_accessible :brand_id
  belongs_to :brand
  validates :brand, presence:true

  has_many :hearts

  def self.with_images
    joins(:variants_including_master=>:images).select("DISTINCT(spree_products.id),spree_products.*")
  end

  def brand=(name)
    logger.info "Looking up brand #{name}, found #{Object.const_get("Spree").const_get("Brand").find_by_name(name)}"
    self.brand_id = Object.const_get("Spree").const_get("Brand").find_by_name(name).id
  end

  scope :by_brand, lambda {|brand_name| joins(:brand).where("spree_brands.name ilike :q",q: "%#{brand_name}%")}
end
