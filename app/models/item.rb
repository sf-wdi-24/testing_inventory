class Item < ActiveRecord::Base
  belongs_to :product

  validates :size, :color, :status, presence: true

end