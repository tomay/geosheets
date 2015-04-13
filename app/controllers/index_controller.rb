class IndexController < ApplicationController
  skip_before_action :verify_authenticity_token

  def getjson
    render :json => response.to_json, :callback => params['callback']
  end
  
  def getsheets
    # use it like this:
    # var duh
    # $.getJSON('http://localhost:3000/sheets/1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0?callback=?',function(data){ console.log(data); duh=data });

    # 
    # params = {}; params['id'] = "1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0"
    url = 'https://docs.google.com/spreadsheets/d/' + params['id'] + '/export?format=csv&gid=0'
    response = HTTParty.get(url)
    data = response.code == 200 ? response.parsed_response : nil
    # puts data
    # TO DO: csv2json? 
    # json = CSV.parse(data).to_json
    # csv = CSV.parse(data)
# puts csv
puts data
puts "resposne \n"
puts response


puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \n"
    # construct geojson

    features = []
    data.each_with_index do |row, i|
      next if i == 0
      coordinates = []
      # puts data[i]
      coordinates << [data[i][3].to_f, data[i][2].to_f]
      # row.each do |cell|
        # puts cell
        features << {
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'Point',
            coordinates: coordinates
          }
        }
      # end
    end
    drr = {}
    drr['type'] = 'FeatureCollection'
    drr['features'] = features

      render :json => drr, :callback => params[:callback]

  end

  def authorize 
    client = Google::APIClient.new
    auth = client.authorization
    auth.client_id = "329132749222-k83tp4rkmsgrl0gf44e8di2rts50e01o.apps.googleusercontent.com"
    auth.client_secret = "9bWW5UvdU08Hm6DJp3pkk8Zu"
    auth.scope = "https://www.googleapis.com/auth/drive " + "https://spreadsheets.google.com/feeds/"
    auth.redirect_uri = "https://pure-brushlands-4880.herokuapp.com/oauth2callback"
    # auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
    # print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
    # https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=329132749222-k83tp4rkmsgrl0gf44e8di2rts50e01o.apps.googleusercontent.com&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&scope=https://www.googleapis.com/auth/drive%20https://spreadsheets.google.com/feeds/
    # code: 4/3h9C0EIuNr919ueoRE_i2ZPtK9zHplwYGvfwxedYAsI.EqIrx0DkqyEYEnp6UAPFm0G2jiJgmQI


  end

end
