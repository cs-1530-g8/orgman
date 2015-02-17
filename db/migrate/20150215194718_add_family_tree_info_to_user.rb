class AddFamilyTreeInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :division, :string
    add_column :users, :extra_info, :string
    add_column :users, :parent_id, :integer
  end
end
