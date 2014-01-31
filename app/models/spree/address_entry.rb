module Spree
  class AddressEntry < ActiveRecord::Base
    attr_accessible :name, :user_id

    belongs_to :address
    belongs_to :user
  end
end
