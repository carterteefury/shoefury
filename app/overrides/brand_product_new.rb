Deface::Override.new(:virtual_path => "spree/admin/products/new",
                     :name => "brand_admin_products_new",
                     :insert_before => "[data-hook='new_product_attrs'], #new_product_attrs[data-hook]",
                     :text => "<%= f.field_container :brand do %>
                        <%= f.label :brand_id, t(:brand) %> <span class=\"required\">*</span><br />
                        <%= f.collection_select :brand_id, Spree::Brand.all, :id, :name, :include_blank => false %>
                      <% end %>",
                     :disabled => false)
