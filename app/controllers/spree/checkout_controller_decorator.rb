Spree::CheckoutController.class_eval do

  def edit
    if @order.state == "address"
      last_order = current_user.orders.where("state = 'complete'").last

      if last_order && !@order.bill_address_id
        @order.bill_address = last_order.bill_address.clone
      end
      if last_order && !@order.ship_address_id
        @order.ship_address = last_order.ship_address.clone
      end
    end
  end

end
