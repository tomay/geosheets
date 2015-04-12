class IndexController < ApplicationController
	skip_before_action :verify_authenticity_token

	def getjson
		render :json => response.to_json, :callback => params['callback']
	end
	
	def getsheets
		# use it like this:
		# $.getJSON('http://localhost:3000/sheets?callback=?',function(data){ console.log(data); duh=data });
		
		data = {:name => "Apple Pie", :price => "3.75"}
	    render :json => data, :callback => params[:callback]

	end

end