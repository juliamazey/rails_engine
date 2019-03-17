Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get 'find', to: 'find#show'
        get 'find_all', to: 'find#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: 'most_revenue#index'
        get 'most_items', to: 'most_items#index'
        get 'revenue', to: 'revenue_date#show'
      end

      resources :merchants, only: [:index, :show] do
        scope module: :merchants do
          get 'revenue', to: 'revenue#show'
          get 'favorite_customer', to: 'customers#show'
          resources :items, only: [:index]
          resources :invoices, only: [:index]
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

      resources :items, only: [:index, :show] do
        scope module: :items do
          resources :invoice_items, only: [:index]
          get 'merchant', to: 'merchants#show'
        end
      end

      namespace :invoice_items do
        get 'find', to: 'find#show'
        get 'find_all', to: 'find#index'
        get 'random', to: 'random#show'
      end

      resources :invoice_items, only: [:index, :show] do
        scope module: :invoice_items do
          get 'invoice', to: 'invoices#show'
          get 'item', to: 'items#show'
        end
      end

      namespace :invoices do
        get 'find', to: 'find#show'
        get 'find_all', to: 'find#index'
        get 'random', to: 'random#show'
      end

      resources :invoices, only: [:index, :show] do
        scope module: :invoices do
          resources :transactions, only: [:index]
          resources :items, only: [:index]
          resources :invoice_items, only: [:index]
          get 'customer', to: 'customers#show'
          get 'merchant', to: 'merchants#show'
        end
      end

      namespace :transactions do
        get 'find', to: 'find#show'
        get 'find_all', to: 'find#index'
        get 'random', to: 'random#show'
        get ':id/invoice', to: "invoices#show"
      end
      resources :transactions, only: [:index, :show]

      namespace :customers do
        get ':id/favorite_merchant', to: "favorite_merchant#show"
        get 'find', to: 'find#show'
        get 'find_all', to: 'find#index'
        get 'random', to: 'random#show'
      end

      resources :customers, only: [:index, :show] do
        scope module: :customers do
          resources :invoices, only: [:index]
          resources :transactions, only: [:index]
        end
      end

    end
  end
end
