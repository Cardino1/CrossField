# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  resources :opportunities, only: [:index, :new, :create]
  resources :investors, only: [:index, :create]
  resources :news, only: [:index]
  resources :subscriptions, only: [:create]

  namespace :admin do
    resources :articles
    resources :opportunities do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :users, only: [:index, :destroy]
    root to: "dashboard#index"
  end
end
