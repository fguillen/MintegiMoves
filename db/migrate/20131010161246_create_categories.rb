class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, :null => false
      t.text :text
      t.integer :position, :null => false

      t.timestamps
    end
  end
end
