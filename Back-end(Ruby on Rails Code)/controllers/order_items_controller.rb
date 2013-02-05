class Admin::OrderItemsController < AdminController

  def index
    @order_items = OrderItem.all
  end

  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @order_item.order = @order
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new(params[:order_item])
    @order_item.order = @order
    if @order_item.save
      respond_to do |format|
        format.html { redirect_to admin_order_path(@order_item.order), notice: "#{@order_item.product_name} successfully added to order"}
        format.json { render json: @order_item.json_with_variant_and_order }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @order_item.json_with_errors }
      end
    end
  end

  def edit
    @order_item = OrderItem.find(params[:id])
    respond_to do|format|
      format.json { render json: @order_item.json_with_variant_and_order }
      format.html
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update_attributes(params[:order_item])
      respond_to do |format|
        format.html { redirect_to admin_order_path(@order_item.order), notice: "#{@order_item.product_name} successfully updated"}
        format.json { render json: @order_item.json_with_variant_and_order }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @order_item.json_with_errors }
      end
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    order_item.destroy
    redirect_to admin_order_path(order_item.order), notice: 'Item successfully deleted'
  end

end
