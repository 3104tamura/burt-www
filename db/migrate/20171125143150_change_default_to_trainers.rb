class ChangeDefaultToTrainers < ActiveRecord::Migration[5.1]
  def up
    change_column :trainers, :gender, :integer, default: 0
  end

  def down
    change_column :trainers, :gender, :integer, default: nil
  end
end
