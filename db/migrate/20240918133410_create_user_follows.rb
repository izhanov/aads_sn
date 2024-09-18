class CreateUserFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :user_follows do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followed, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: "PENDING"

      t.timestamps
    end

    add_index :user_follows, [:follower_id, :followed_id], unique: true
  end
end
