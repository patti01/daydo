class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_task, only: [:new, :create]

  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.task = Task.find(params[:task_id])
    @comments = @task.comments
    authorize @comment

    if @comment.save
      respond_to do |format|
        format.html { redirect_to task_path(@comment.task) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'models/show' }
        format.js
      end
    end
  end

  def destroy
    @comment.delete
    authorize @comment
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:detail)
  end

  def set_comment
    @comment = Comment.find(params[:id]) if Comment.count != 0
  end
end
