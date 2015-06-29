class SheetsController < ApplicationController

	# 1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0
	# data = session.spreadsheet_by_key('1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0').worksheets[0]

	# call like this 
	# localhost:3000/1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0


	# skip_before_action :verify_authenticity_token

	# def getjson
	# 	render :json => response.to_json, :callback => params['callback']
	# end
	
	# def getmap
	# 	return getjson if !request.original_url.split('/').last 
	# 	puts 'ab ab ab'
	# 	puts params
 #        puts 'hi'
 #        # render 'map'
	# end


	def map

		sheet = Sheet.new
		rows = sheet.rows(params['id'])

		# return geojson
		@geojson = sheet.geojson(rows)

		# return wkt
		# @wkt = sheet.wkt(rows)

		# render the map, or return geojson
		# render request.original_url.split('/').last == 'map' ? 'map' : :json => @geojson
		render request.original_url.split('/').last == 'map' ? 'map' : :json => @geojson

	end

	    # render :json => geojson, :callback => params[:callback]



end
