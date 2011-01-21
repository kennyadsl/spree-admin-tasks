class SpreeAdminTasksHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_tabs do
    %( <%= tab :admin_tasks %>)
  end
  
  insert_before :admin_order_show_addresses , 'admin/admin_tasks/order_task_link'
  insert_before :admin_product_form_right , 'admin/admin_tasks/product_task_link'
  
  insert_after :admin_orders_index_row_actions , 'admin/admin_tasks/order_icon_link'
end