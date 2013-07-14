class ApplicationController < ActionController::Base
  
  protected

  def twitter_api
    @_twitter_api || @_twitter_api = Twitter::Client.new(
      consumer_key: TWITTER_CONSUMER_KEY,
      consumer_secret: TWITTER_CONSUMER_SECRET,
      oauth_token: TWITTER_ACCESS_TOKEN,
      oauth_token_secret: TWITTER_ACCESS_TOKEN_SECRET
    )
  end

  def _log(msg, indent=0)
    if 'test' == Rails.env
      p ' ' * indent + msg.to_s
    else
      logger.debug ' ' * indent + msg.to_s
    end
  end
end
