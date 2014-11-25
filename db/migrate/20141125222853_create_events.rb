class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.integer :fine
      t.boolean :self_submit_attendance
      t.boolean :self_submit_excuse
      t.integer :semester
      t.integer :event_type_id

      t.timestamps
    end
  end
end
