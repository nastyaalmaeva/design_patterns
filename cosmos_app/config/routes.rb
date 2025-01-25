Rails.application.routes.draw do
  root 'welcome#index'

  resources :stars do
    member do
      get 'confirm_delete'
    end
  end

  resources :planets do
    member do
      get 'confirm_delete'
    end
  end

  resources :sattelites do
    member do
      get 'confirm_delete'
    end
  end
end
