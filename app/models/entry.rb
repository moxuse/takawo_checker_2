class Entry < ActiveRecord::Base
  belongs_to :user

  def self.set_data(res, user)
    Entry.new(
      user_id: user.id, 
      content: res[:content],
      source_url: res[:source_url],
      tweet_id: res[:tweet_id]
    )
  end

end
