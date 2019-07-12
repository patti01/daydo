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
    @task = Task.new(task_params)
    @task.user = current_user
    authorize @task

    if @task.save
      redirect_to tasks_path
    end

    #A DEBUGGUER
    # if @task.save
    #   respond_to do |format|
    #     format.html { redirect_to tasks_path, notice: 'Task was successfully created !' }
    #     format.js { }
    #   end
    # else
    #   respond_to do |format|
    #     format.html { render :index }
    #     format.js { }
    #   end
    # end
  end

  def show
    authorize @task
    @comment = Comment.new
    @comments = @task.comments
  end

  def update
    authorize @task
    @task.update(task_params)

    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to tasks_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js
      end
    end
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
