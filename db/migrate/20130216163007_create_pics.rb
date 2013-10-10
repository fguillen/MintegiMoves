class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.integer :picable_id, :null => false
      t.string  :picable_type, :null => false
      t.attachment :attach
      t.integer :position, :null => false
      t.timestamps
    end
  end
end
