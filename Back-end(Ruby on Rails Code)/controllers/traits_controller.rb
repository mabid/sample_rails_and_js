class Admin::TraitsController < AdminController

  def index
    @traits = Trait.all
  end

  def new
    @trait = Trait.new
  end

  def edit
    @trait = Trait.find(params[:id])
  end

  def create
    @trait = Trait.new(params[:trait])
    if @trait.save
      redirect_to admin_traits_path, notice: "#{@trait.name} successfully created"
    else
      render 'new'
    end
  end

  def update
    @trait = Trait.find(params[:id])
    if @trait.update_attributes(params[:trait])
      redirect_to admin_traits_path, notice: "#{@trait.name} successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    trait = Trait.find(params[:id])
    trait.destroy
    redirect_to admin_traits_path, notice: "#{trait.name} successfully deleted"
  end

end
