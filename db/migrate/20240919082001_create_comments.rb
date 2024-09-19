class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.references :parent, foreign_key: { to_table: :comments }
      t.references :author, polymorphic: true, null: false

      t.text :content, null: false
      t.timestamps
    end
  end
end
