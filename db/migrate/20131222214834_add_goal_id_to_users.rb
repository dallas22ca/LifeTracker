class AddGoalIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :goal_id, :integer
    add_index :users, :goal_id
  end
end
