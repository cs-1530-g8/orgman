class AddExcuseInfoToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :excuse_reason, :string
  end
end
