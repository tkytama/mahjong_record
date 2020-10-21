Rails.application.routes.draw do
  get 'mahjong_record/top'
  root to: 'mahjong_record#top'
  devise_for :users
  
  resources :users, only: [:show] do
    member do
      get :point
    end
  end
  
  resources :rooms, only: [:new, :create, :show, :edit, :update] do
    resources :games, only: [:new, :create, :edit, :update, :index, :delete], param: :count do
      member do
	get :confirm_tobi_yakitori
	patch ":confirm_tobi_yakitori" => "games#input_tobi_yakitori"
      end
    end

    resources :logout, only: [:new, :create, :edit, :update,:index, :destroy],param: :count do
      member do
        get :confirm_tobi_yakitori
	patch ":confirm_tobi_yakitori" => "logout#input_tobi_yakitori"
      end
    end

    resources :player, only: [:show]
    member do
      get :enter
      put :entering      
      patch "game_records" => "rooms#input_game_records"
      get :game_records
    end

  end

  resources :enter_rooms, only: [:new, :create]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
