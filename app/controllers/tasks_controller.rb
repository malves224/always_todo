class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { errors: [I18n.t('activerecord.errors.models.task.record_not_found')] }, status: :not_found
  end
  before_action :require_login
  before_action :validate_owner, only: %i[update destroy]

  def index
    tasks = Task.all
    render json: tasks, status: :ok
  end

  def show
    task = Task.find(params[:id])
    render json: task, status: :ok
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end

  def validate_owner
    @task = Task.unscoped.find(params[:id])
    return if @task.user_id == Current.user.id

    render json: { errors: [I18n.t('tasks_controller.errors.unpermitted_task')] }, status: :forbidden
  end
end
