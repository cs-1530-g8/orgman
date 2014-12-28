class AddExcuseIdToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :excuse_id, :integer
  end
end
