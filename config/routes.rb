TakawoChecker2::Application.routes.draw do
  resources :entries
  resources :users
  get "crawlers/get_words"
  post "crawlers/save_db"
  post '/search' => 'index#search', :as => 'show_search_results'

  root :to => 'index#index', :as => 'index'
end
