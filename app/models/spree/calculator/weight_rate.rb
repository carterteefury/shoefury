module Spree
    class Calculator::WeightRate < Calculator
      preference :per_pound, :decimal, :default=>0

      attr_accessible :preferred_per_pound

      def self.description
        I18n.t(:weight_rate)
      end

      def self.available?(object)
        true
      end

      def compute(object)
        case object
        when Spree::Order
          return unless object.present? and object.line_items.present?
          weight = object.line_items.map{|i| i.variant.product.brand.free_shipping ? 0 : item_weight(i) * i.quantity}.sum
          value = weight * BigDecimal(self.preferred_per_pound.to_s) 
          (value * 100).round.to_f / 100
        when Spree::Shipment
          return unless object.present? and object.line_items.present?
          weight = object.line_items.map{|i| i.variant.product.brand.free_shipping ? 0 :  item_weight(i) * i.quantity}.sum
          value = weight * BigDecimal(self.preferred_per_pound.to_s) 
          (value * 100).round.to_f / 100
        when Spree::LineItem
          weight = object.variant.product.brand.free_shipping ? 0 : item_weight(object) * object.quantity
          value = weight * BigDecimal(self.preferred_per_pound.to_s) 
          (value * 100).round.to_f / 100
        else
          0
        end
      end

      private
      def item_weight(item)
        item.variant.weight ? item.variant.weight : 1
      end
    end
end
