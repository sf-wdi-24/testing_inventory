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

    describe "sell_through" do
      before do
        @product = FactoryGirl.create(:product)
        5.times do
          random_status = ["in", "out", "sold", "clearanced"].sample
          @product.items.create(size: "M", color: "burgundy", status: random_status)
        end
        total_items = @product.items.count
        items_sold = @product.items.where(status: "sold").count
        @sell_through = items_sold / total_items
      end

      it "should calculate product's overall sell-through rate" do
        expect(@product.sell_through).to eq(@sell_through)
      end
    end
  end

end