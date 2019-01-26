class UpdateLogBookEvents < ActiveRecord::Migration
  def up
    remove_column :log_book_events, :text
    add_column :log_book_events, :differences, :text, :limit => 16777215
    add_index :log_book_events, [:historizable_id, :historizable_type]
  end
end
