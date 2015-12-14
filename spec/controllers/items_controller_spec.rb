require "rails_helper"

RSpec.describe ItemsController, type: :controller do
  before do
    @product = FactoryGirl.create(:product)
  end

  describe "#new" do
    before do
      get :new, product_id: @product.id
    end

    it "should assign @product" do
      expect(assigns(:product)).to eq(@product)
    end

    it "should assign @item" do
      expect(assigns(:item)).to be_instance_of(Item)
    end

    it "should render the :new view" do
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "success" do
      before do
        @items_count = @product.items.count
        post :create, product_id: @product.id, item: {
          size: "M",
          color: "burgundy",
          status: "in"
        }
      end

      it "should add new item to product" do
        expect(@product.items.count).to eq(@items_count + 1)
      end

      it "should redirect_to 'product_item_path'" do
        expect(response.status).to be(302)
        expect(response.location).to match(/\/products\/\d+\/items\/\d+/)
      end
    end

    context "failed validations" do
      before do
        # create blank item (fails validations)
        post :create, product_id: @product.id, item: {
          size: nil,
          color: nil,
          status: nil
        }
      end

      it "should display an error message" do
        expect(flash[:error]).to be_present
      end

      it "should redirect to 'new_product_item_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_product_item_path(@product, @item))
      end
    end
  end

  describe "#show" do
    before do
      @item = FactoryGirl.create(:item)
      @product.items << @item
      get :show, product_id: @product.id, id: @item.id
    end

    it "should assign @product" do
      expect(assigns(:product)).to eq(@product)
    end

    it "should assign @item" do
      expect(assigns(:item)).to eq(@item)
    end

    it "should render the :show view" do
      expect(response).to render_template(:show)
    end
  end

  describe "#edit" do
    before do
      @item = FactoryGirl.create(:item)
      @product.items << @item
      get :edit, product_id: @product.id, id: @item.id
    end

    it "should assign @product" do
      expect(assigns(:product)).to eq(@product)
    end

    it "should assign @item" do
      expect(assigns(:item)).to eq(@item)
    end

    it "should render the :edit view" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    before do
      @item = FactoryGirl.create(:item)
      @product.items << @item
    end

    context "success" do
      before do
        @new_size = "M"
        @new_color = "burgundy"
        @new_status = "sold"

        put :update, product_id: @product.id, id: @item.id, item: {
          size: @new_size,
          color: @new_color,
          status: @new_status
        }
        
        # reload @item to get changes from :update
        @item.reload
      end

      it "should update item in the database" do
        expect(@item.size).to eq(@new_size)
        expect(@item.color).to eq(@new_color)
        expect(@item.status).to eq(@new_status)
      end

      it "should redirect_to 'product_item_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(product_item_path(@product, @item))
      end
    end

    context "failed validations" do
      before do
        # update with blank item params (fails validations)
        put :update, product_id: @product.id, id: @item.id, item: {
          size: nil,
          color: nil,
          status: nil
        }
      end

      it "should display an error message" do
        expect(flash[:error]).to be_present
      end

      it "should redirect_to 'edit_product_item_path'" do
        expect(response).to redirect_to(edit_product_item_path(@product, @item))
      end
    end
  end

  describe "#destroy" do
    before do
      item = FactoryGirl.create(:item)
      @product.items << item
      @items_count = @product.items.count
      delete :destroy, product_id: @product.id, id: item.id
    end

    it "should remove product's item from the database" do
      expect(@product.items.count).to eq(@items_count - 1)
    end

    it "should redirect_to 'product_path'" do
      expect(response.status).to be(302)
      expect(response).to redirect_to(product_path(@product))
    end
  end
end