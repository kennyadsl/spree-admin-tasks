Rails.application.routes.draw do
  namespace :admin do
    resources :admin_tasks
  end
end

