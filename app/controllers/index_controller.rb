class IndexController < ApplicationController
	def index
      
	end

	def search
      query = params[:keywords]
      yahoo_res = YahooAPI.new(YAHOO_APP_ID, query).send.parse_json
      yahoo_res = yahoo_res.present? ? yahoo_res.keys : query.split(" ")

      if Rails.env == "development"
        @results = yahoo_res.collect { |res| Entry.where('content LIKE ?', "%#{res}%") }.flatten.uniq
      else
        @results = yahoo_res.collect { |res| Entry.where('content ILIKE ?', "%#{res}%") }.flatten.uniq
      end
      render 'index/search_results' and return
	end
end
