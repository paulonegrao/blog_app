class CategoriesController < ApplicationController

    def index
      @favorite = params[:favorite]
      if  @favorite.present?
          @category  = current_user.liked_categories.order("title ASC").uniq
      else
        @category = Category.all.order("title ASC")
      end
    end

    def new
      @category = Category.new
    end

    def create
      category_params = params.require(:category).permit(:name)
      @category = Category.new(category_params)
      if @category.save
        redirect_to categories_path, notice: "Category created"
      else
        render :new
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      category_params = params.require(:category).permit(:name)
      @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to categories_path, notice: "Category updated"
      else
        render :edit
      end
    end

    def destroy
      @category = Category.find(params[:id])
      @category.destroy
      flash[:notice] = "Category deleted"
      redirect_to categories_path
    end

end
