Spree::Shipment.class_eval do
  scope :by_brand, lambda { |brand_id| joins(:inventory_units => {:variant=> :product} ).having("spree_products.brand_id = :q ", q: brand_id).group(
    "spree_shipments.id, spree_shipments.tracking, spree_shipments.number, spree_shipments.cost, spree_shipments.shipped_at,
   spree_shipments.order_id, spree_shipments.shipping_method_id, spree_shipments.address_id,spree_shipments.created_at,
   spree_shipments.updated_at, spree_shipments.state, spree_products.brand_id") }

   def calculator
     self.shipping_method.calculator
   end

   private

   def ensure_correct_adjustment
     if adjustment
       adjustment.originator = self
       adjustment.amount = self.calculator.compute(self)
       adjustment.save
     else
       a = Spree::Adjustment.create(label: I18n.t(:shipping))
       a.originator = self
       a.adjustable = self.order
       a.amount = self.calculator.compute(self)
       a.save
       self.adjustment = a
     end
     reload #ensure adjustment is present on later saves
   end
end
