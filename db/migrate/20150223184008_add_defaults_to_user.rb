class AddDefaultsToUser < ActiveRecord::Migration
  def change
    change_column_default(:users, :status, 'pending')
    change_column_null(:users, :status, false)
  end
end
