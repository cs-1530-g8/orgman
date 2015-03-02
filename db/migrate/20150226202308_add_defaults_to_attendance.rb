class AddDefaultsToAttendance < ActiveRecord::Migration
  def change
    change_column_default(:attendances, :present, false)
    change_column_default(:attendances, :excused, nil)
  end
end
