class RemoveExcusesTable < ActiveRecord::Migration
  def change
    drop_table :excuses
    remove_column :attendances, :excuse_id
    remove_column :attendances, :fine_id
    remove_column :fines, :user_id
  end
end
