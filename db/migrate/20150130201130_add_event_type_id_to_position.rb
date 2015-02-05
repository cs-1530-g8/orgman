class AddEventTypeIdToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :event_type_id, :integer
  end
end
