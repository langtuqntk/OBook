class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.integer :numberpage
      t.string :image
      t.string :file

      t.timestamps
    end
  end
end
