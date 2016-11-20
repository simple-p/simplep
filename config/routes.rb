Rails.application.routes.draw do
	get 'task_followers/create'

	resources :activities
	resources :projects do
		resources :tasks
		resources :teams
	end

	resources :tasks do
		resources :comments
		resources :task_followers
	end
	resources :homes
	devise_for :users, :controller => {:registrations => 'users/registrations'}
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'home#index'
	get 'contactus' => "home#contactus"
	get 'aboutus' => "home#aboutus"
	get 'dashboard' => "home#dashboard"
	resources :teams do
		resources 'memberships'
		post 'memberships/create', as: 'add_member'
	end
end
