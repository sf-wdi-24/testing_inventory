class Product < ActiveRecord::Base

  validates :name, :description, :category, :sku, :wholesale, :retail, presence: true

  def margin
    (retail - wholesale) / retail
  end

end