# encoding: UTF-8
require "twitter"
class TweetCrawler
  attr_reader :responses

  def initialize(twitter_client)
    @_twitter_api = twitter_client
    @responses
  end

  def search(since_id)
    since_id = 97668377518145539 if since_id.nil?
    words = "#takawo杯"
    max_id = nil
    counter = 0
    responses_collection = []

    while true
      unless max_id
        res = @_twitter_api.search(words, :since_id => since_id, :count => 100)
      else
        res = @_twitter_api.search(words, :since_id => since_id, :max_id => max_id, :count => 100)
      end

      max_id = res.next_results? ? res.next_results[:max_id] : nil
      counter += 1
      responses_collection << res.results
      break if max_id.nil? || counter > 150
    end

    @responses = parse_response(responses_collection)
    return self
  end

  def parse_response(responses_collection)
    responses_collection.collect do |response|
      response.collect do |attrs|
        {
          :content => attrs[:text],
          :tweet_id => attrs[:id],
          :user_id => attrs[:user][:id],
          :user_name => attrs[:user][:name],
          :source_url => attrs[:url]
        }
      end
    end.flatten!.reverse
  end
end