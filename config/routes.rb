Rails.application.routes.draw do
  root 'home#index'
  get 'contactus' => "home#contactus"
  get 'aboutus' => "home#aboutus"
  get 'dashboard' => "home#dashboard"
end
