class ChangeDefaultToUsers < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :gender, :integer, default: 0
  end

  def down
    change_column :users, :gender, :integer, default: nil
  end
end
