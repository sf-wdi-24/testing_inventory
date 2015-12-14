require "rails_helper"

RSpec.describe Product, type: :model do
  
  describe "methods" do
    describe "#margin" do
      before do
        @product = FactoryGirl.create(:product)
        @retail_margin = (@product.retail - @product.wholesale) / @product.retail
      end

      it "should calculate product's retail margin" do
        expect(@product.margin).to eq(@retail_margin)
      end
    end
  end

end