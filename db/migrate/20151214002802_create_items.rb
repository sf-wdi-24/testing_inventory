class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :size
      t.string :color
      t.string :status
      t.belongs_to :product

      t.timestamps null: false
    end
  end
end
