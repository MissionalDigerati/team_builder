Rails.application.routes.draw do

  resources :contacts do
    resources :support_states do
      member do
        put :quick_edit
      end
    end
  end
  resources :numbers
  resources :occasions
  resources :donations
  resources :tasks
  resources :notes
  resources :presences
  resources :archives do
    member do
      get :download
    end
  end

  get 'reports/progress', to: 'reports#progress'
  get 'tasks/completed/:id', to: 'tasks#completed', as: :complete_task
  get 'tags/:tag', to: 'contacts#index', as: :tag

  root 'pages#home'

end
