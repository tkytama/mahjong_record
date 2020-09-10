Rails.application.routes.draw do
  get 'mahjong_record/top'
  root to: 'mahjong_record#top'
  devise_for :users
  
  resources :users, only: [:show] do
    member do
      get :point
    end
  end
  
  resources :rooms, only: [:new, :create, :show] do
    resources :games, only:[:new, :create, :edit, :update, :index, :delete]
    member do
      get :enter
      put :entering      
      get :game_records
      put :input_game_records
    end

  end

  resources :enter_rooms, only: [:new, :create]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
