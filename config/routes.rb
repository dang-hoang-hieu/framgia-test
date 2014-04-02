FramgiaTest::Application.routes.draw do
  root "static_pages#home"
  match "/help",    to: "static_pages#help",    via: "get"
  match "/about",   to: "static_pages#about",   via: "get"
  match "/contact", to: "static_pages#contact", via: "get"
  match "/signup",  to: "users#new",            via: "get"
  match "/signin",  to: "sessions#new",         via: "get"
  match "/signout", to: "sessions#destroy",      via: "delete" 
  match "/admin/signin",  to: "admin/sessions#new", via: "get"
  match "/admin/signin",  to: "admin/sessions#create", via: "post"
  match "/admin/signout", to: "admin/sessions#destroy",      via: "delete"
  resources :users, except: [:index, :delete]
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :examinations, only: [:index, :create, :show, :edit] do
    resources :answers_sheets, only: [:create, :edit, :update]
  end
  
  resources :exams, only: [:index, :show]

  namespace :admin do
    root "subjects#index"
    resources :subjects
    resources :levels
    resources :questions
    resources :exams do
      resource :user_list
    end
    resources :examinations do
      resources :answers_sheets
    end
    resources :users, except: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    
    match "monitors",  to: "monitors#index", via: "get"
    match "monitors/import",  to: "monitors#import", via: "post"
    match "monitors/export",  to: "monitors#export", via: "get"    
  end
end
