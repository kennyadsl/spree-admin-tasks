require 'spree_admin_tasks_hooks'

module SpreeAdminTasks
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      Rails.env.production? ? require('reports_controller_decorator') : load('reports_controller_decorator.rb')
      Admin::ReportsController::AVAILABLE_REPORTS.merge!({ :open_orders => {:name => "Maksamatta", :description => "Maksamattomat tilaukset"}  })
    end

    config.to_prepare &method(:activate).to_proc
  end
end
