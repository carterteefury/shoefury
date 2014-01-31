Deface::Override.new(:virtual_path => "spree/admin/users/show",
                     :name => "admin_users_brand",
                     :insert_after => "[data-hook='roles']",
                     :text => "<tr><th><%= t(:brand) %></th><td><%= @user.brand_id.present? ? @user.brand.name : 'none' %></td></tr>",
                     :disabled => false)
