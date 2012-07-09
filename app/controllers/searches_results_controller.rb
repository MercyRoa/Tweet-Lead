class SearchesResultsController < ApplicationController
	# GET /searches_results
	# GET /searches_results.json
	def index
	  #@searches_results = Profile.all
	  @searches_results = SearchesResult.all

	  respond_to do |format|
	    format.html # index.html.erb
	    format.json { render json: @searches_results }
	  end
	end
end
