class CreateFines < ActiveRecord::Migration
  def change
    create_table :fines do |t|
      t.integer :user_id
      t.integer :attendance_id
      t.boolean :paid

      t.timestamps
    end
  end
end
