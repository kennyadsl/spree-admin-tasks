Rails.application.routes.draw do
  namespace :admin do
    resources :admin_tasks do
      member do
        get :done
      end
    end
  end
end

