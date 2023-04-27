class Api::V1::TodosController < ApplicationController
  
  protect_from_forgery with: :null_session
  before_action :set_todo, only: [:show, :update, :destroy, :undo_destroy]


  # def index
  #   @todos = Todo.all.order(created_at: :desc)
  #   if @todos.empty?
  #     render json: { message: "No todos found" }, status: :not_found
  #   else
  #     render json: @todos
  #   end    
  # end

#To show Todo list in pagination
  def index
    @todos = Todo.where.not(view: false).page(params[:page]).per(params[:per_page])
    if @todos.empty?
      render json: { message: "No todos found" }, status: :not_found
    else
      render json: @todos
    end    
  end
  
#To Find all todo items by tag
  def index_by_tag
    @todos = Todo.where(:tags => /#{params[:tag]}/i).order(created_at: :desc)
    if @todos.empty?
      render json: { message: "Tag '#{params[:tag]}' not found" }, status: :not_found
    else
      render json: @todos
    end    
  end
  
  # def show
  #   if @todo
  #     render json: @todo, status: :ok
  #   else
  #     render json: { message: "Todo not found" }, status: :not_found
  #   end
  # end
  
#Create todo item
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo, status: :created
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

#Modify todo item
  def update
    if @todo.update(todo_params)
      render json: @todo, status: :ok
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

#Delete todo item(permanently from database)
  # def destroy
  #   if @todo
  #     @todo.destroy
  #     head :no_content
  #   else
  #     render json: { message: "Todo not found" }, status: :not_found
  #   end
  # end

#Delete todo item(Not permanently)
  def destroy
    if @todo.update(view:false)
      render json: @todo, status: :ok
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end


#undo deleted todo item
  def undo_destroy
    if @todo
      if @todo.update(view:true)
         render json: @todo, status: :ok
      else
         render json: { message: "Todo not found in trash" }, status: :not_found
      end
    end
  end  
  

  private
#set_todo retrieves the Todo item with the specified id parameter
  def set_todo
    @todo = Todo.find(params[:id])
  end

#todo_params defines the parameters that are permitted for the create and update actions
  def todo_params
    params.require(:todo).permit(:title, :description,  :tags, :status, :view)
  end
end

