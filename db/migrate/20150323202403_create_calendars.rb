class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :name, present: true
      t.string :url, present: true
      t.boolean :primary, default: false

      t.timestamps
    end
  end
end
