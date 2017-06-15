class CreateUserBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_books do |t|
      t.integer :readstatus
      t.boolean :isFavorite
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
