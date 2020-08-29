Rails.application.routes.draw do
  get 'mahjong_record/top'
  root to: 'mahjong_record#top'
  devise_for :users
  
  resources :users do
    member do
      get :point
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
