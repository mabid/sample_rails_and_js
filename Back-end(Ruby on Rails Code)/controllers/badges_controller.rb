class Admin::BadgesController < AdminController

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def edit
    @badge = Badge.find(params[:id])
  end

  def create
    @badge = Badge.new(params[:badge])
    if @badge.save
      redirect_to admin_badges_path, notice: "#{@badge.name} successfully created"
    else
      render 'new'
    end
  end

  def update
    @badge = Badge.find(params[:id])
    if @badge.update_attributes(params[:badge])
      redirect_to admin_badges_path, notice: "#{@badge.name} successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    badge = Badge.find(params[:id])
    badge.destroy
    redirect_to admin_badges_path, notice: "#{badge.name} successfully deleted"
  end


end



