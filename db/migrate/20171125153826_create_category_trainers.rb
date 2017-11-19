class CreateCategoryTrainers < ActiveRecord::Migration[5.1]
  def change
    create_table :category_trainers, id: false do |t|
      t.references :category
      t.references :trainer
    end
  end
end
