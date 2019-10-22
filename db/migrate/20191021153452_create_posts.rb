class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.float :review
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
