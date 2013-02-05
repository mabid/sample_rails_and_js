class Admin::UserAddressesController < AdminController

  def new
    load_user
    @address = Address.new    
  end

  def create
    load_user
    @address = Address.new(params[:address])
    @address.user = @user
    if @address.save
      redirect_to admin_user_path(@address.user), notice: 'New address successfully added'
    else
      render 'new'
    end
  end

  def edit
    load_user
    load_address
  end

  def update
    load_user
    load_address
    if @address.update_attributes(params[:address])
      redirect_to admin_user_path(@address.user), notice: 'Address successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    load_address
    @address.destroy
    redirect_to admin_user_path(@address.user), notice: 'Address successfully deleted'
  end

  private

    def load_user
      @user = User.find(params[:user_id])
    end

    def load_address
      @address = Address.find(params[:id])
    end

end
