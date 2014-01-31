module Spree
  module Admin
    class BrandsController < ResourceController
      before_filter :load_data

      protected

      def load_data
        @brands = Brand.all
      end
    end
  end
end
