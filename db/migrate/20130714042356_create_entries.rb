class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :user_id
      t.text :content
      t.text :source_url
      t.integer :rt_count
      t.integer :fav_count
      t.datetime :updated_at

      t.timestamps
    end
  end
end
