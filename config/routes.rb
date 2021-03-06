Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :blogs, only: %w(index new create edit show destroy update) do
        resources :entries, only: %w(new create edit show destroy update) do
            resources :comments, only: %w(new create destroy approve)do
                member do
                    post 'approve'
                end
            end
        end
    end
end
