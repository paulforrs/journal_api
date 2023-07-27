class TasksController < ApplicationController
    before_action :check_auth
    before_action :set_task, only: [:edit, :update, :show, :destroy]
    before_action :is_category_valid?, only: [:update, :create]
    
    def index
        @tasks = @user.tasks
        render json: @tasks
    end
    def show
        @task = @user.tasks
        render json: @task
    end 
    def new
        @task = Task.new
    end
    
    def create
        @task = @user.tasks.new(tasks_params)
        if @task.save
            render json: @task
        else
            render json: @task.errors, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        @task.update(tasks_params)
    end

    def destroy
        if @task.delete

        else
            render json: {message: "User does not exist"}, status: :bad_request
        end
    end

    private
    def tasks_params
        params.require(:tasks).permit(:name, :category_id)
    end

    def set_task
        @task = @user.tasks.find(params[:id])
    end

    def is_category_valid?
        if @user.categories.find_by_id(tasks_params[:category_id])
        else
            render json: {message: "Category does't exist"}
        end
    end
end
