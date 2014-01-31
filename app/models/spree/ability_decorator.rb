module Spree
  class AbilityDecorator
    include CanCan::Ability

    def initialize(user)
      user ||= User.new
      if user.brand_id.present?
        can :manage, Order do |order|
          order && order.line_items.includes(:product).where("spree_products.brand_id = :q",q:user.brand_id).present?
        end
      end
    end
  end

  Ability.register_ability(AbilityDecorator)
end
