class CreateExcuses < ActiveRecord::Migration
  def change
    create_table :excuses do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :reason
      t.boolean :accepted

      t.timestamps
    end
  end
end
