class CreateRatingBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :rating_books do |t|
      t.integer :rating
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
