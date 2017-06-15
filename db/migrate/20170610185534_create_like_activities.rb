class CreateLikeActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :like_activities do |t|
      t.boolean :islike
      t.references :user, foreign_key: true
      t.references :user_activity, foreign_key: true

      t.timestamps
    end
  end
end
