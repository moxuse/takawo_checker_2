class IndexController < ApplicationController
	def index
      
	end

	def search
      keywords = params[:keywords].split(' ')
      _log "keywords= #{keywords}"

      @results = Entry.where('content LIKE ?', "%#{keywords[0]}%")
      _log "results= #{@results.inspect}"

      render 'index/search_results' and return
	end
end
