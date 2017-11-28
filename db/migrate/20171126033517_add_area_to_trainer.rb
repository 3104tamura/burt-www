class AddAreaToTrainer < ActiveRecord::Migration[5.1]
  def change
    add_column :trainers, :area, :integer
  end
end
