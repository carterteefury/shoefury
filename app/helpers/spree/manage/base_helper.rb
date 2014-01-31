module Spree
  module Manage
    module BaseHelper

      def spree_dom_id(record)
        dom_id(record, 'spree')
      end
    end
  end
end
