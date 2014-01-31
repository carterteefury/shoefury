Spree::Order.class_eval do

  scope :by_brand, lambda { |brand_id| joins(:line_items => :product ).having("spree_products.brand_id = :q ", q: brand_id).group(
    "spree_orders.id, spree_orders.number, spree_orders.item_total, spree_orders.total, spree_orders.state, spree_orders.adjustment_total,
    spree_orders.credit_total, spree_orders.user_id , spree_orders.created_at , spree_orders.updated_at , spree_orders.completed_at,
    spree_orders.bill_address_id, spree_orders.ship_address_id, spree_orders.payment_total, spree_orders.shipping_method_id,
    spree_orders.shipment_state, spree_orders.payment_state, spree_orders.email, spree_orders.special_instructions, spree_products.brand_id")}

  #scope :unshipped, lambda { |brand_id| Spree::Shipment.by_brand(brand_id).where(:state=>'ready').includes(:order).map(&:order)}
  scope :unshipped, lambda { |brand_id| joins(:shipments=>{:inventory_units=>{:variant=>:product}}).where("spree_products.brand_id=:q and spree_shipments.state='ready'",q:brand_id).uniq}
  scope :shipped, lambda { |brand_id| joins(:shipments=>{:inventory_units=>{:variant=>:product}}).where("spree_products.brand_id=:q and spree_shipments.state='shipped'",q:brand_id).uniq}

  # delete the default shipment and create split shipments out of it
  def split_shipment!
    self.shipments.destroy_all
    units = self.inventory_units.includes(:variant=>:product)
    units.group_by{|u| u.variant.product.brand_id}.each do |brand_id,units|
      s = Spree::Shipment.create!({ :order => self, :shipping_method => shipping_method, :address => self.ship_address,
                              :inventory_units => units}, :without_protection => true)
    end
  end

  def finalize!
    update_attribute(:completed_at, Time.now)
      Spree::InventoryUnit.assign_opening_inventory(self)
      # lock any optional adjustments (coupon promotions, etc.)
      adjustments.optional.each { |adjustment| adjustment.update_attribute('locked', true) }
      deliver_order_confirmation_email

      self.state_changes.create({
        :previous_state => 'cart',
        :next_state     => 'complete',
        :name           => 'order' ,
        :user_id        => (Spree::User.respond_to?(:current) && Spree::User.current.try(:id)) || self.user_id
      }, :without_protection => true)

      self.split_shipment!
  end

  def amount(brand_id)
    line_items.joins(:product).map{|i| i.product.brand_id == brand_id ? i.amount : 0 }.sum
  end

  def brand_total(brand_id)
    amount(brand_id) + brand_adjustment_total(brand_id)
  end

  #private

  # update adjustment for shipment without passing order
  def update_adjustments
    self.adjustments.reload.each do |adjustment|
      if adjustment.originator.class == Spree::Shipment
        adjustment.update!
      else
        adjustment.update!(self)
      end
    end
  end

  def brand_adjustment_total(brand_id)
    adjustments.eligible.map{|a| (a.source_type == "Spree::Shipment" and a.source.line_items.first.variant.product.brand_id != brand_id) ? 0 : a.amount}.sum
  end

end
