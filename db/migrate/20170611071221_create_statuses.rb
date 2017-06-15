class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :content
      t.string :image
      t.string :location
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
