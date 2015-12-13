require "rails_helper"

RSpec.describe ProductsController, type: :controller do

  describe "#index" do
    before do
      @all_products = Product.all
      get :index
    end

    it "should assign @products" do
      expect(assigns(:products)).to eq(@all_products)
    end

    it "should render the :index view" do
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    before do
      get :new
    end

    it "should assign @product" do
      expect(assigns(:product)).to be_instance_of(Product)
    end

    it "should render the :new view" do
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "success" do
      before do
        @products_count = Product.count
        post :create, product: {  }
      end

      it "should add new product to the database" do
        expect(Product.count).to eq(@products_count + 1)
      end

      it "should redirect_to 'product_path'" do
        expect(response.status).to be(302)
        expect(response.location).to match(/\/products\/\d+/)
      end
    end

    context "failed validations" do
      before do
        # create blank product (fails validations)
        post :create, product: {  }
      end

      it "should display an error message" do
        expect(flash[:error]).to be_present
      end

      it "should redirect to 'new_product_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_product_path)
      end
    end
  end

  describe "#show" do
    before do
      @product = FactoryGirl.create(:product)
      get :show, id: @product.id
    end

    it "should assign @product" do
      expect(assigns(:product)).to eq(@product)
    end

    it "should render the :show view" do
      expect(response).to render_template(:show)
    end
  end

  describe "#edit" do
    before do
      @product = FactoryGirl.create(:product)
      get :edit, id: @product.id
    end

    it "should assign @product" do
      expect(assigns(:product)).to eq(@product)
    end

    it "should render the :edit view" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    before do
      @product = FactoryGirl.create(:product)
    end

    context "success" do
      before do
        @new_name =
        @new_description =
        @new_category =
        put :update, id: @product.id, product: {  }
        
        # reload @product to get changes from :update
        @product.reload
      end

      it "should update product in the database" do
        expect(@product.name).to eq(@new_name)
        expect(@product.description).to eq(@new_description)
      end

      it "should redirect_to 'product_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(product_path(@product))
      end
    end

    context "failed validations" do
      before do
        # update with blank product params (fails validations)
        put :update, id: @product.id, product: {  }
      end

      it "should display an error message" do
        expect(flash[:error]).to be_present
      end

      it "should redirect_to 'edit_product_path'" do
        expect(response).to redirect_to(edit_product_path)
      end
    end
  end

  describe "#destroy" do
    before do
      product = FactoryGirl.create(:product)
      @all_products = Product.count
      delete :destroy, id: product.id
    end

    it "should remove product from the database" do
      expect(Product.count).to eq(@all_products - 1)
    end

    it "should redirect_to 'root_path'" do
      expect(response.status).to be(302)
      expect(response).to redirect_to(root_path)
    end
  end
end