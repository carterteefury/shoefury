Deface::Override.new(:virtual_path => "spree/admin/products/index",
                     :name => "admin_import_products",
                     :insert_before => "#new_product_link",
                     :text => "<li id='import_products_link'><%= button_link_to t(:import_products),import_admin_products_url, {:icon => 'add'} %></li>",
                     :disabled => true)
