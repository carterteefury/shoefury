Deface::Override.new(:virtual_path => "spree/admin/users/_form",
                     :name => "admin_users_brand",
                     :insert_after => "[data-hook='admin_user_form_fields']",
                     :partial => "spree/admin/users/brand",
                     :disabled => false)
