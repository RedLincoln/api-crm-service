Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: 'api', path: 'api' do
    scope module: 'v1', path: 'v1' do
      post "auth/login", to: "auth#login", as: 'login'
      get "auth/auto_login", to: "auth#auto_login", as: 'auto_login'
    end
  end
end
