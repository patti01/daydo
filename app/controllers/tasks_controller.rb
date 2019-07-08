class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
  end

  def new
  end
end
