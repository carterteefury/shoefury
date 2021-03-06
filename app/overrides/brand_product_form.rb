Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "brand_admin_products_form",
                     :insert_bottom => "[data-hook='admin_product_form_left'], #admin_product_form_left[data-hook]",
                     :text => "<%= f.field_container :brand do %>
                        <%= f.label :brand_id, t(:brand) %> <span class=\"required\">*</span><br />
                        <%= f.collection_select :brand_id, Spree::Brand.all, :id, :name, :include_blank => false %>
                      <% end %>",
                     :disabled => false)
