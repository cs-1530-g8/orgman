class AddDefaultsToEventSelfSubmit < ActiveRecord::Migration
  def change
    change_column_default(:events, :self_submit_attendance, false)
    change_column_default(:events, :self_submit_excuse, false)
  end
end
