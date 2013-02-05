class Admin::ProductsController < AdminController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to admin_product_path(@product), notice: 'New product successfully created'
    else
      render 'new'
    end
  end

  def edit
    load_product
  end

  def update
    load_product
    if @product.update_attributes(params[:product])
      redirect_to admin_product_path(@product), notice: 'Product successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    load_product
    @product.destroy
    redirect_to admin_products_path, notice: 'Product successfully deleted'
  end

  def edit_categories
    load_product
    @categories = Category.scoped
  end

  def update_categories
    load_product
    @product.category_ids = params[:product][:category_ids]
    redirect_to admin_product_path(@product), notice: "#{@product.name}'s categories successfully updated"
  end

  def edit_traits
    load_product
    @product.new_product_traits.each { |trait| @product.product_traits.build(trait: trait) }
  end

  def update_traits
    load_product
    set_product_traits_attributes
    if @product.save
      redirect_to admin_product_path(@product), notice: "#{@product.name}'s traits successfully updated"
    else
      redirect_to admin_product_path(@product), alert: "Warning! There was a problem updating #{@product.name}'s traits. Please double check that they are correct"
    end
  end

  def edit_badges
    load_product
    @badges = Badge.all
  end

  def update_badges
    load_product
    @product.badge_ids = params[:product][:badge_ids]
    redirect_to admin_product_path(@product), notice: "#{@product.name}'s badges successfully updated"
  end

  private

    def load_product
      @product = Product.find(params[:id])
    end

    def set_product_traits_attributes
      params[:product][:product_traits_attributes].map do |product_trait|
        if product_trait[:id].present?
          product_trait['_destroy'] = true if product_trait[:value].blank?
          product_trait
        end
      end
      @product.attributes = params[:product]
    end

end
