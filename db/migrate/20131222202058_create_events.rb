class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date
      t.text :notes
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
