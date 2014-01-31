Spree::BaseHelper.module_eval do
  
  def link_to_cart(text = nil)
    return "" if current_spree_page?(cart_path)

    text = text ? h(text) : t('cart')
    css_class = nil

    if current_order.nil? or current_order.line_items.empty?
      text = "#{text}"
      css_class = 'empty'
    else
      text = "#{text}: <span class='amount'>#{order_subtotal(current_order)}</span>".html_safe
      css_class = 'full'
    end

    link_to text, cart_path, :class => css_class
  end

end