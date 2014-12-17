Rails.application.routes.draw do
  get 'amazon/sign_key'

    resources :recipes, except: [:new, :edit], defaults: {format: :json} do
      resources :images, except: [:new, :edit], defaults: {format: :json} 
    end
    resources :notes, except: [:new, :edit], defaults: {format: :json} 
    resources :lists do
      resources :tasks, except: [:new, :edit], defaults: {format: :json} 
    end
end
