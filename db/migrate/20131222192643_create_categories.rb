class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.belongs_to :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
