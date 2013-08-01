class CrawlersController < ApplicationController
  http_basic_authenticate_with :name => ADMIN_NAME, :password => ADMIN_PASS

  def get_words
    #TODO tweet_idにindex張る
    

    t = TweetCrawler.new(twitter_api).search()
    @res = t.responses
  end

  def save_db
    @res = params[:res] || TweetCrawler.new(twitter_api).search.responses
  end
end
