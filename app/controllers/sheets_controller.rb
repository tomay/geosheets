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
		# get GoogleDrive session
		session = Rails.configuration.session
		data = session.spreadsheet_by_key(params['id']).worksheets[0].rows

		# return geojson
		features = []
		lat = data[0].index('lat')
		lng = data[0].index('long')
				
		data.each_index {|i|
			next if i == 0
			coordinates = []
			coordinates.push(data[i][lng].to_f)
			coordinates.push(data[i][lat].to_f)
			features << {
				type: 'Feature',
				properties: {},
				geometry: {
				  type: 'Point',
				  coordinates: coordinates
				}
			}
		}
		@geojson = {}
		@geojson['type'] = 'FeatureCollection'
		@geojson['features'] = features

		render request.original_url.split('/').last == 'map' ? 'map' : :json => @geojson

	end

	    # render :json => geojson, :callback => params[:callback]



end
