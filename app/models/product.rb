class Product < ActiveRecord::Base
  has_many :items, dependent: :destroy

  validates :name, :description, :category, :sku, :wholesale, :retail, presence: true

  def margin
    (retail - wholesale) / retail
  end

end