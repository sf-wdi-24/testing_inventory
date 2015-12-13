class ProductsController < ApplicationController
  before_filter :set_product, except: [:index, :new, :create]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Successfully created product."
      redirect_to product_path(@product)
    else
      flash[:error] = @product.errors.full_messages.join(", ")
      redirect_to new_product_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      flash[:notice] = "Successfully updated product."
      redirect_to product_path(@product)
    else
      flash[:error] = @product.errors.full_messages.join(", ")
      redirect_to edit_product_path(@product)
    end
  end

  def destroy
    @product.destroy
    flash[:notice] = "Successfully deleted product."
    redirect_to root_path
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :category, :sku, :wholesale, :retail)
    end

    def set_product
      product_id = params[:id]
      @product = Product.find_by_id(product_id)
    end

end