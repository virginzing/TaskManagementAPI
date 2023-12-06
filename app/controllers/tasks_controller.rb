class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :set_undo_task, only: [:undo]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    result = Tasks::CreateService.call(current_user, task_params)

    if result[:success]
      render json: result[:value]
    else
      response_error(result[:value].errors.full_messages)
    end
  end

  # PATCH/PUT /tasks/1
  def update
    result = Tasks::UpdateService.call(current_user, @task, task_params)

    if result[:success]
      render json: result[:value]
    else
      response_error(result[:value].errors.full_messages)
    end
  end

  # DELETE /tasks/1
  def destroy
    result = Tasks::DeleteService.call(current_user, @task)

    if result[:success]
      render json: result[:value]
    else
      response_error(result[:value].errors.full_messages)
    end
  end

  # POST /tasks/1/undo
  def undo
    result = Tasks::UndoService.call(@task)

    if result[:success]
      render json: result[:value]
    else
      response_error(result[:value].errors.full_messages)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find_by_id(params[:id])

      return response_error("Task id: #{params[:id]} not found.") unless @task
    end

    def set_undo_task
      @task = Task.unscoped.find_by_id(params[:id])

      return response_error("Task id: #{params[:id]} not found.") unless @task
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :status)
    end
end
