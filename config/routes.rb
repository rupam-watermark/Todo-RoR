Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      #The resources :todos line defines a set of RESTful routes for a Todo model,which include index, show, new, create, edit, update, and destroy actions.
      #/api/v1/todos for standard CRUD operations on todos
      resources :todos do
        #The collection do block defines a custom route for the index_by_tag action, which takes a :tag parameter in the URL
        #/api/v1/todos/tags/:tag to list todos with a specific tag
        collection do
          get 'tags/:tag', action: :index_by_tag, as: :tagged
        end
        #/api/v1/todos/:id/undo_destroy to restore a deleted todo.
        member do
          post 'undo_destroy'
        end
      end
    end
  end
end
