class AddTweetIdToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :tweet_id, :string
  end

  def self.down
    remove_column :entries, :tweet_id
  end
end
