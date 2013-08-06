class IndexController < ApplicationController
	def index
      
	end

	def search
      input = Validators::ValidationEntry.new(:query => params[:keywords])

      unless input.valid?
        @errors = input.errors.messages.values.flatten
        render 'index/search_results' and return
      end

      yahoo_res = YahooAPI.new(YAHOO_APP_ID, input.query).send.parse_json
      yahoo_res = yahoo_res.present? ? yahoo_res.keys : input.query.split(" ")
      if Rails.env == "development"
        @results = yahoo_res.collect { |res| Entry.where('content LIKE ?', "%#{res}%") }.flatten.uniq
      else
        @results = yahoo_res.collect { |res| Entry.where('content ILIKE ?', "%#{res}%") }.flatten.uniq
      end
      render 'index/search_results' and return
	end
end
