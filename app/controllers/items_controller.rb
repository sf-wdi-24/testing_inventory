class ItemsController < ApplicationController
  before_filter :set_product
  before_filter :set_item, except: [:new, :create]

  def new
    @item = Item.new
  end

  def create
    @item = @product.items.new(item_params)
    if @item.save
      flash[:notice] = "Successfully created item."
      redirect_to product_item_path(@product, @item)
    else
      flash[:error] = @item.errors.full_messages.join(", ")
      redirect_to new_product_item_path(@product)
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update_attributes(item_params)
      flash[:notice] = "Successfully updated item."
      redirect_to product_item_path(@product, @item)
    else
      flash[:error] = @item.errors.full_messages.join(", ")
      redirect_to edit_product_item_path(@product, @item)
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "Successfully deleted item."
    redirect_to product_path(@product)
  end

  private

    def item_params
      params.require(:item).permit(:size, :color, :status)
    end

    def set_product
      product_id = params[:product_id]
      @product = Product.find_by_id(product_id)
    end

    def set_item
      item_id = params[:id]
      @item = Item.find_by_id(item_id)
    end

end