Rails.application.routes.draw do
  
  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }, controllers: { registrations: 'registrations' }

  resources :tests, only: :index do
    resources :questions, shallow: true, only: :index do
      resources :answers, shallow: true, only: :index
    end

    member do
      post :start
    end
  end

  resources :test_passages, only: %i[ show update ] do
    resources :gists, only: :create
    
    member do
      get :result
    end
  end

  namespace :admin do
    resources :tests do
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end 

    resources :gists, only: :index
  end
  
end
