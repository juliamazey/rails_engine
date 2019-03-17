Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get 'find', to: 'find#show'
        get 'find_all', to: 'find#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: 'most_revenues#index'
        get 'most_items', to: 'most_items#index'
        get 'revenue', to: 'revenues#index'
      end

      resources :merchants, only: [:index, :show] do
        scope module: :merchants do
          get 'revenue', to: 'revenues#show'
          get 'favorite_customer', to: 'customers#show'
          resources :items, only: [:index]
        end
      end


      namespace :items do
        get 'find', to: 'find#show'
        get 'find_all', to: 'find#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: "most_revenues#index"
        get 'most_items', to: "most_items#index"
        get ':id/best_day', to: "best_day#show"
      end

      resources :items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :customers, only: [:index, :show]


      namespace :customers do
        get ':id/favorite_merchant', to: "favorite_merchant#show"
      end

    end
  end
end
