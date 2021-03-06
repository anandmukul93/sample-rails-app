Rails.application.routes.draw do
	get 'sessions/new'

	resources :users, :sessions

	root 'static_pages#home', as:'index'

	get '/help', to: 'static_pages#help'

	get '/about', to: 'static_pages#about'

	get '/contact_page' => 'static_pages#contact'

	get '/signup', to: 'users#new'

	post '/signup', to: 'users#create'

	get '/login', to: 'sessions#new'

	post '/login', to: 'sessions#create'

	delete '/logout', to:'sessions#destroy'

	namespace :phonebook do
		get '/search', to: 'contacts#search'
		get '/add', to:'contacts#add'
	end

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
