class TasksController < ApplicationController
    before_action :check_auth
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    
    def index
        @tasks = @user.tasks.all
        puts @tasks
        render json: @tasks
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
        
        # respond_to do |format|
        #     if @task.save
        #         format.html { redirect_to user_path(@task), notice:"User was successfully created" }
        #         format.json { render :show, status: :created, location: @task}
        #     else
        #         format.html { render :new, status: :unprocessably_entity}
        #         format.json { render json: @task.errors, status: :unprocessable_entity}
        #     end  
        # end
    end

    def edit
    end

    def update
        @task.update(tasks_params)
    end

    def destroy
        if @task.destroy!
            @task
        else
            render json: {message: "User does not exist"}, status: :bad_request
        end
    end

    private
    def tasks_params
        params.require(:tasks).permit(:name, :category_id)
    end

    def set_user
        @task = @user.tasks.find(params[:id])
    end
end
