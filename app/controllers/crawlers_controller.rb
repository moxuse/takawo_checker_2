class CrawlersController < ApplicationController
  http_basic_authenticate_with :name => ADMIN_NAME, :password => ADMIN_PASS

  def get_words
    since_id = Entry.last.try(:tweet_id) || nil
    t = TweetCrawler.new(twitter_api).search(since_id)
    @@responses = @responses = t.responses
  end

  def save_db
    ActiveRecord::Base.transaction do
      @@responses.each do |res|
        u = User.where(name: res[:user_name]).first_or_create{ |user| user.name = res[:user_name] }
        e = Entry.set_data(res, u)
        e.save!
      end
    end

    render :text => "ok"
    rescue => e
      render :text => "error!#{e}"
  end

end
