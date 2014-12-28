class AddAttendanceIdToExcuse < ActiveRecord::Migration
  def change
    add_column :excuses, :attendance_id, :integer
  end
end
