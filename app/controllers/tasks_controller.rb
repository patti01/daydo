class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @tasks = policy_scope(Task).where(user_id: current_user.id)
    @task = Task.new
  end

  def new
    @task = Task.new
    authorize @task
  end

  def create
    @task = current_user.tasks.build(task_params)
    authorize @task
    @task.save
    redirect_to tasks_path
  end

  def show
    authorize @task
    @comment = Comment.new
    @comments = @task.comments
  end

  def update
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    @task_id = @task.id
    authorize @task
    @task.destroy

    respond_to do |format|
      format.html { render 'tasks/index' }
      format.js
    end
  end

  private

  def set_task
    @task = Task.find(params[:id]) if Task.count != 0
    authorize @task
  end

  def task_params
    params.require(:task).permit(:title, :deadline, :completed, :sort_priority)
  end
end
