Rails.application.routes.draw do
  resources :reports
  resources :notifications
  get 'task_followers/create'
  post 'notifications/new_feeds', as: "new_feeds"
  post 'notifications/set_notifications', as: "set_notifications"
  resources :blogs

  post 'tasks/sort'
  resources :activities
  resources :teams do
    resources :projects
  end
  resources :projects do
    resources :tasks
    post 'tasks/:id/owner' => "tasks#owner", as: "task_owner"
    post 'tasks/:id/deadline' => "tasks#deadline", as: "task_deadline"
    post 'tasks/:id/completed' => "tasks#completed", as: "task_completed"
    resources :blogs
  end

  get 'tasks/user_team'

  delete 'projects/:id/' => "projects#destroy", as: "destroy_project"
  delete 'teams/:id' => "teams#destroy", as: "destroy_team"
  resources :tasks do
    resources :comments
    resources :task_followers
  end

  resources :homes
  devise_for :users, :controllers => {:registrations => 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get 'contactus' => "home#contactus"
  get 'aboutus' => "home#aboutus"
  get 'dashboard' => "dashboards#index"
  get 'search' => "tasks#search"
  get 'termsandconditions' => "home#termsandconditions"
  resources :teams do
    resources 'memberships'
    post 'memberships/create', as: 'add_member'
    delete 'memberships/destroy', as: 'delete_member'
  end

  get 'switch' => "teams#switch"
end
