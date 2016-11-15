Rails.application.routes.draw do
	devise_for :users

	resources :teams do
		resources 'memberships'
		post 'memberships/create', as: 'add_member'
	end
	root 'home#index'

	get 'contactus' => "home#contactus"
	get 'aboutus' => "home#aboutus"
	get 'dashboard' => "home#dashboard"
end
