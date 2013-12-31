class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :category, index: true
      t.belongs_to :event, index: true
      t.text :content
      t.boolean :quantifiable
      t.float :quantity

      t.timestamps
    end
  end
end
