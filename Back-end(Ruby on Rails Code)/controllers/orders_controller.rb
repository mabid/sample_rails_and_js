class Admin::OrdersController < AdminController

  helper_method :sort_column, :sort_direction

  def index
    @orders = Order.order("#{sort_column} #{sort_direction}").paginate(:page => params[:page]).per_page(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def guest_order
    @order = Order.new(:guest_order => true)
    if @order.save
      redirect_to edit_admin_order_path(@order), notice: "Order ##{@order.id} successfully created"
    else
      redirect_to admin_orders_path, alert: "Order not created Some error occured" 
    end
  end

  def create
    @order = Order.new(params[:order])
    if @order.save
      redirect_to edit_admin_order_path(@order), notice: "Order ##{@order.id} successfully created"
    else
      render 'new'
    end
  end
  
  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      respond_to do|format|
        format.html { redirect_to admin_order_path(@order), notice: "Order ##{@order.id} successfully updated" }
        format.json { render :json => @order }
      end
    else
      respond_to do|format|
        format.html { render 'edit' }
        format.json { render :json => {:errors => @order.errors } }
      end
    end
  end  

  def destroy
    order = Order.find(params[:id])
    order.destroy
    redirect_to admin_orders_path, notice: "Order ##{order.id} successfully deleted"
  end

  private

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : 'id'
   end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end
