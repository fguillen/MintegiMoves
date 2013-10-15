class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title, :null => false
      t.text :intro, :null => false
      t.text :text
      t.integer :position, :null => false
      t.references :category, :null => false

      t.timestamps
    end
  end
end
