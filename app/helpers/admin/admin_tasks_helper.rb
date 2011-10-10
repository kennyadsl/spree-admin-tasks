module Admin::AdminTasksHelper

  def source_link task
    return " " unless task.source_id
    case task.source_type 
    when "Product"
      link_to task.source.name , edit_admin_product_url(task.source)
    when "Order"
      link_to( "#{task.source.number} ( #{task.source.total} )" , admin_order_url(task.source)) 
    else
      task.source_id ?  task.source.to_s : ""
    end
  end
  
  def done_link admin_task
    if admin_task.done 
      I18n.t('done') 
    else
      link_to I18n.t('to_do') , done_admin_admin_task_url(admin_task)
    end
  end
  
  def self.find_task(object)
    return unless object
    task = AdminTask.find_by_source_id(object.id)
  end
  
end
