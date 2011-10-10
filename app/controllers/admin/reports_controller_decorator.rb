Admin::ReportsController.class_eval do

  before_filter :kludge 
  
  def kludge
    return if Admin::ReportsController::AVAILABLE_REPORTS.has_key?(:open_orders)
    Admin::ReportsController::AVAILABLE_REPORTS.merge!({ :open_orders => {:name => "Maksamatta", :description => "Maksamattomat tilaukset"}  })
  end

  def open_orders
    params[:search] = {} unless params[:search]
    params[:search][:meta_sort] = "number.asc"
    params[:search][:payment_state_equals] = "balance_due" unless params[:csv]
    if params[:csv]
      params[:search] = {} unless params[:search]

      if params[:search][:created_at_greater_than].blank?
        params[:search][:created_at_greater_than] = Time.zone.now.beginning_of_month
      else
        params[:search][:created_at_greater_than] = Time.zone.parse(params[:search][:created_at_greater_than]).beginning_of_day rescue Time.zone.now.beginning_of_month
      end

      if params[:search] && !params[:search][:created_at_less_than].blank?
        params[:search][:created_at_less_than] =
                                        Time.zone.parse(params[:search][:created_at_less_than]).end_of_day rescue ""
      end

      if params[:search].delete(:completed_at_is_not_null) == "1"
        params[:search][:completed_at_is_not_null] = true
      else
        params[:search][:completed_at_is_not_null] = false
      end

      params[:search][:meta_sort] ||= "created_at.desc"

      @search = Order.metasearch(params[:search])
      @orders = @search
      @item_total = @search.sum(:item_total)
      @adjustment_total = @search.sum(:adjustment_total)
      @sales_total = @search.sum(:total)
       ## obove copy paste should be rethought
      send_data( render_to_string( :csv , :layout => false) , :type => "application/csv" , :filename => "tilaukset.csv") 
      return
    end
    sales_total
  end
end

Order.class_eval do
  def kom val
    val = (val*100).to_i / 100.0
    val = val.to_s
    val.sub! "." , ","
    val
  end
  def alv13
    a13 = adjustments.detect { |a| a.label == "Alv 13"}.amount  
    kom((a13 * 1.13 ) / 0.13) 
  end
  def alv23
    a23 = adjustments.detect { |a| a.label == "Alv 23"}.amount  
    kom( (a23 * 1.23 ) / 0.23 )
  end
end

