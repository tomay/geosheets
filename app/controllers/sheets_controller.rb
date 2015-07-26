class SheetsController < ApplicationController

	# example:  https://pure-brushlands-4880.herokuapp.com/sheets/1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0/map
    # 			https://pure-brushlands-4880.herokuapp.com/sheets/1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0
	def map

		sheet = Sheet.new
		rows = sheet.rows(params['id'])

		# return geojson
		@geojson = sheet.geojson(rows)

		# TO DO: return wkt
		# @wkt = sheet.wkt(rows)

		# render the map, or return geojson
		# render request.original_url.split('/').last == 'map' ? 'map' : :json => @geojson
		render request.original_url.split('/').last == 'map' ? 'map' : :json => @geojson

	end

end
