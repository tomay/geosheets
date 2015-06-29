class Sheet < ActiveRecord::Base
    # get a hook to the GoogleDrive::Session


	def rows(id)
		return Rails.configuration.session.spreadsheet_by_key(id).worksheets[0].rows
	end


	def geojson(rows)

		# get case insensitive index of various possible keys
		header = rows[0].map(&:downcase)
		lat ||= header.index('lat')
		lat ||= header.index('latitude')

		lng ||= header.index('long')
		lng ||= header.index('longitude')
        
        wkt = header.index('wkt')

		features = []

		rows.each_index {|i|
			next if i == 0
			coordinates = []
			coordinates.push(rows[i][lng].to_f)
			coordinates.push(rows[i][lat].to_f)

	        properties = {}
			header.each_with_index {|head, j|
				next if j == lat || j == lng || j == wkt
				properties[head] = rows[i][j]
			}

			features << {
				type: 'Feature',
				properties: properties,
				geometry: {
				  type: 'Point',
				  coordinates: coordinates
				}
			}
		}
		geojson = {}
		geojson['type'] = 'FeatureCollection'
		geojson['features'] = features
	
		return geojson

	end

	def wkt(rows)
		# get case insensitive index of various possible keys
		header = rows[0].map(&:downcase)
		lat ||= header.index('lat')
		lat ||= header.index('latitude')

		lng ||= header.index('long')
		lng ||= header.index('longitude')
        
        wkt = header.index('wkt')

        # wkt = "POINT(#{lng} #{lat})" if !wkt 

        if !wkt
        	coords = []
        	rows.each_index {|i|
        		next if i == 0
        		coords.push(rows[i][lng] + ' ' + rows[i][lat])
        	}
        	wkt = 'MULTIPOINT(' + coords.join(',') + ')'
        end

        return wkt

	end

end
