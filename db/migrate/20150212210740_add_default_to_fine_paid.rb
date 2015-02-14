class AddDefaultToFinePaid < ActiveRecord::Migration
  def change
    change_column_default(:fines, :paid, false)
  end
end
