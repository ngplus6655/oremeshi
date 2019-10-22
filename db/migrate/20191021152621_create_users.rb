class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :login_id, null: false
      t.string :password_digest
      t.integer :gender, null: false
      t.datetime :birthday
      t.string :prefecture
      t.text :introduce
      t.integer :taste, null: false
      t.boolean :admin, null: false
      t.timestamps
    end
  end
end
