Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home', as:'index'

  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'

  get '/contact' => 'static_pages#contact', as: 'contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
