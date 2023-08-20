Rails.application.routes.draw do

  namespace "api" do 
    resources :products
    resources :categories
  end

  scope 'api' do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
end 