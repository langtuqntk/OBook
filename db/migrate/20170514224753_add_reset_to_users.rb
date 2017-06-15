class AddResetToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
    add_column :users, :username, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :address, :string
    add_column :users, :numberphone, :string
    add_column :users, :image, :string
  end
end
