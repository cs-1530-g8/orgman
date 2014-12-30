class AddFineIdToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :fine_id, :integer
  end
end
