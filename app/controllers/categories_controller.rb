class CategoriesController < ApplicationController
    before_action :check_auth
    before_action :set_category, only: [:edit, :update, :show, :destroy]
    
    def index
        @categories = @user.categories
        render json: @categories
    end

    def show
        @category
    end

    def create
        begin
            @category = @user.categories.new(category_params)
            if @category.save
                render json: @category
            else
                render json: @category.errors, status: :unprocessable_entity
            end
        rescue => exception
            render json: exception
        end
    end

    def edit
    end

    def update
        @category.update(category_params)
    end

    def destroy
        if @category.destroy!
            render json: @category
        else
            render json: {message: "User does not exist"}, status: :bad_request
        end
    end

    private
    def category_params
        params.require(:categories).permit(:name)
    end

    def set_category
        begin
            @category = @user.categories.find(params[:id])
        rescue => exception
            render json: exception
        end
    end
end
