class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :title
      t.string :contenthtml
      t.integer :status
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
