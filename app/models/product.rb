class Product < ActiveRecord::Base
  has_many :items, dependent: :destroy

  validates :name, :description, :category, :sku, :wholesale, :retail, presence: true

  def margin
    (retail - wholesale) / retail
  end

  def sell_through
    total_items = items.count
    items_sold = items.where(status: "sold").count
    (total_items - items_sold) / total_items
  end

end