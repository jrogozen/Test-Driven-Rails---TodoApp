class TodosController < ApplicationController
  before_filter :authenticate

  def index
    if !session.nil?
      @todos = Todo.where(:email => session[:current_email])
    else
      @todos = Todo.all
    end
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.create(todo_params.merge(email: session[:current_email]))
    redirect_to todos_path
  end

  private

  def todo_params
    params.require(:todo).permit(:title)
  end

end