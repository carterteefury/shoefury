Deface::Override.new(:virtual_path => "spree/admin/products/index",
                     :name => "brand_admin_products_index_headers",
                     :insert_top => "[data-hook='admin_products_index_headers'], #admin_products_index_headers[data-hook]",
                     :text => "<th><%= sort_link @search,:brand_id, t(:brand)%></th>",
                     :disabled => false)
Deface::Override.new(:virtual_path => "spree/admin/products/index",
                     :name => "brand_admin_products_index_row",
                     :insert_top => "[data-hook='admin_products_index_rows'], #admin_products_index_rows[data-hook]",
                     :text => "<td><%= product.brand.name rescue '' %></td>",
                     :disabled => false)
