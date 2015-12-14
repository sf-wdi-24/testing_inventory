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
        wholesale_price = Random.new.rand(1.0..100.0).round(2)

        post :create, product: {
          name: FFaker::Lorem.words(5).join(" "),
          description: FFaker::Lorem.sentence,
          category: FFaker::Lorem.words(3).join,
          sku: FFaker::Lorem.words(2).join,
          wholesale: wholesale_price,
          retail: wholesale_price * 4
        }
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
        post :create, product: {
          name: nil,
          description: nil,
          category: nil,
          sku: nil,
          wholesale: nil,
          retail: nil
        }
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
        @new_name = FFaker::Lorem.words(5).join(" ")
        @new_description = FFaker::Lorem.sentence
        @new_category = FFaker::Lorem.words(3).join
        @new_sku = FFaker::Lorem.words(2).join
        @new_wholesale = Random.new.rand(1.0..100.0).round(2)
        @new_retail = @new_wholesale * 4

        put :update, id: @product.id, product: { 
          name: @new_name,
          description: @new_description,
          category: @new_category,
          sku: @new_sku,
          wholesale: @new_wholesale,
          retail: @new_retail
        }
        
        # reload @product to get changes from :update
        @product.reload
      end

      it "should update product in the database" do
        expect(@product.name).to eq(@new_name)
        expect(@product.description).to eq(@new_description)
        expect(@product.category).to eq(@new_category)
        expect(@product.sku).to eq(@new_sku)
        expect(@product.wholesale).to eq(@new_wholesale)
        expect(@product.retail).to eq(@new_retail)
      end

      it "should redirect_to 'product_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(product_path(@product))
      end
    end

    context "failed validations" do
      before do
        # update with blank product params (fails validations)
        put :update, id: @product.id, product: { 
          name: nil,
          description: nil,
          category: nil,
          sku: nil,
          wholesale: nil,
          retail: nil
        }
      end

      it "should display an error message" do
        expect(flash[:error]).to be_present
      end

      it "should redirect_to 'edit_product_path'" do
        expect(response).to redirect_to(edit_product_path(@product))
      end
    end
  end

  describe "#destroy" do
    before do
      product = FactoryGirl.create(:product)
      @products_count = Product.count
      delete :destroy, id: product.id
    end

    it "should remove product from the database" do
      expect(Product.count).to eq(@products_count - 1)
    end

    it "should redirect_to 'root_path'" do
      expect(response.status).to be(302)
      expect(response).to redirect_to(root_path)
    end
  end
end