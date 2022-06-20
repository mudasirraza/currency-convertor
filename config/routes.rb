Rails.application.routes.draw do
  resources :dashboards, path: '/', only: [:index, :create]
end
