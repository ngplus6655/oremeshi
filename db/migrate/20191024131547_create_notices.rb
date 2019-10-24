class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.text :content
      t.date :released_at
      t.date :expired_at

      t.timestamps
    end
  end
end
