module Spree::Search
  class BrandSearch < Spree::Core::Search::Base

    def retrieve_products
      @products_scope = get_base_scope
      @products_scope = @products_scope.order("((spree_products.hearts_count+1)/(EXTRACT(days FROM NOW()-spree_products.created_at)+1)) DESC, id")
      curr_page = page || 1

      @products = @products_scope.includes([:master]).page(curr_page).per(per_page)
    end

    protected

    def get_products_conditions_for(base_scope, query)
      products = base_scope.like_any([:name, :description], query.split) | base_scope.by_brand(query)
      base_scope.where(["spree_products.id IN (?)", products.map(&:id).uniq])
    end
  end
end
