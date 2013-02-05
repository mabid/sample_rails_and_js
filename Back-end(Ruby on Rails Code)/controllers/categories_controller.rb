class Admin::CategoriesController < AdminController

  def index
    @categories = Category.scoped
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to admin_categories_path, notice: "#{@category.name} successfully created"
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to admin_categories_path, notice: "#{@category.name} successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to admin_categories_path, notice: "#{category.name} successfully deleted"
  end

end
