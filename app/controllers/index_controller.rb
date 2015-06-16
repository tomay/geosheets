class IndexController < ApplicationController
	
	# 1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0
	# data = session.spreadsheet_by_key('1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0').worksheets[0]

	# call like this 
	# localhost:3000/1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0


	skip_before_action :verify_authenticity_token

	def getjson
		render :json => response.to_json, :callback => params['callback']
	end
	
	def getsheets

		session = authorize
		data = session.spreadsheet_by_key(params['id']).worksheets[0].rows

		puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \n"
		# construct geojson
		features = []
		# coordinates = []
		# shape_id = nil 
		# CSV.foreach(csv, headers: true) do |row|  

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
		drr = {}
		drr['type'] = 'FeatureCollection'
		drr['features'] = features

	    render :json => drr, :callback => params[:callback]

	end

	def authorize 

		Dotenv.load
		# then get the token and initiate a session
		access_token = GoogleOauth2Installed.access_token
		session = GoogleDrive.login_with_oauth(access_token)

		return session

	end




end