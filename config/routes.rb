Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :blogs, only: %w(index new create edit show update) do
        resources :entries, only: %w(index new create edit show update) do
            resources :comments
        end
    end
end
