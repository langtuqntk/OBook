class CreateUserActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :user_activities do |t|
      t.integer :book_affected
      t.integer :user_affected
      t.integer :status_id
      t.references :user, foreign_key: true
      t.references :activity, foreign_key: true
      t.timestamps
    end
  end
end
