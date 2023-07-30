class CategoriesController < ApplicationController
    before_action :check_auth
    before_action :set_category, only: [:edit, :update, :show, :destroy]
    
    def index
        @categories = @user.categories
        render :index
    end

    def show
        @category
    end

    def create
        begin
            @category = @user.categories.new(category_params)
            if @category.save
                render :create
            else
                render json: @category.errors, status: :unprocessable_entity
            end
        rescue => exception
            render json: exception
        end
    end

    def update
        if @category.update(category_params)
            render :update
        end
    end

    def destroy
        if @category.destroy!
            render :delete
        else
            render json: {status: "success", body: @category.errors}
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
