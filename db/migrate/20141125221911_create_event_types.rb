class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :name
      t.integer :points_required
      t.integer :percentage_attendance_required

      t.timestamps
    end
  end
end
