SecretShareAjax::Application.routes.draw do
  resources :secrets, :only => [:create]
  resource :session, :only => [:create, :destroy, :new]
  resources :users, :only => [:create, :new, :show] do
    resources :secrets, :only => [:new]
  end

  root :to => "users#show"
end
