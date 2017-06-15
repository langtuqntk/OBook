class CreateReviewBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :review_books do |t|
      t.string :title
      t.string :contenthtml
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
