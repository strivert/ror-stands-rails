# rails generate model Micropost content:text user:references
class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    # Put the most selective field first, i.e. the field that narrows down the number of rows fastest.
    # The index will only be used insofar as you use its columns in sequence starting at the beginning. 
    # i.e. if you index on [:user_id, :created_at], 
    # you can perform a fast query on user_id or user_id AND created_at, but NOT on created_at.
    add_index :microposts, [:user_id, :created_at]
  end
end
