Rails.application.routes.draw do
  
  devise_for :users
  
  resources :topics do
    resources :posts, except: [:index] do
      resource :summary, except: [:edit, :update, :destroy]
    end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
  
end
