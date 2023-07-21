class CategoriesController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    
    def index
        @catergories = Category.all
    end

    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)

        if @category.save
            @category
        else
            render json: @category.errors, status: :unprocessable_entity
        end
        
        # respond_to do |format|
        #     if @user.save
        #         format.html { redirect_to user_path(@user), notice:"User was successfully created" }
        #         format.json { render :show, status: :created, location: @user}
        #     else
        #         format.html { render :new, status: :unprocessably_entity}
        #         format.json { render json: @user.errors, status: :unprocessable_entity}
        #     end  
        # end
    end

    def edit
    end

    def update
        @category.update(category_params)
    end

    def destroy
        if @category.destroy!
            @category
        else
            render json: {message: "User does not exist"}, status: :bad_request
        end
    end

    private
    def category_params
        params.require(:categories).permit(:name)
    end

    def set_category
        @category = Category.find(params[:id])
    end
end
