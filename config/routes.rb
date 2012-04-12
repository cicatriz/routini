Routini::Application.routes.draw do
  devise_for :users

  root :to => "situations#index"
  match '/help' => 'pages#help'

  resources :tasks, :only => [ :destroy, :index, :show, :edit, :update ] do
    resources :microtasks, :only => [ :create, :update, :index ]
    resources :logs, :only => [ :create, :index ]
  end
  resources :situations, :only => [ :create, :destroy, :show, :edit, :update, :index ] do
    resources :tasks, :only => [ :create ]
  end
end
