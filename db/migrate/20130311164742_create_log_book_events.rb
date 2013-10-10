class CreateLogBookEvents < ActiveRecord::Migration
  def self.up
    create_table :log_book_events do |t|
      t.integer :historian_id
      t.string :historian_type
      t.integer :historizable_id
      t.string :historizable_type
      t.string :text, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :log_book_events
  end
end