#GEOSHEETS

An app to generate [geojson](http://geojson.org/), or a simple Leaflet map, from public Google Drive spreadsheets. 

Here is a [demo, returning a map](https://pure-brushlands-4880.herokuapp.com/sheets/1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0/map), which draws data from [this Google Drive spreadsheet](https://docs.google.com/spreadsheets/d/1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0/edit#gid=0).

Here is the same sheet, [returning geojson](https://pure-brushlands-4880.herokuapp.com/sheets/1lGzP8DrVZKqh-RuocHe-n2wsbZxN0vCzVsAYRys-6b0)

##How it works

Made possible with OAuth and the Google Drive API v2, plus Rails and Leaflet. 

##Use

1. Create a Google Drive spreadsheet. At a minimum, include columns named "latitude" and "longitude". Case is not important ("lat" and "long" will also work). Additional columns will show up as attributes in marker popups, and properties in geojson. 

2. Make the sheet public, and bounce it off of the heroku app like so:

    #### returns geojson
    https://pure-brushlands-4880.herokuapp.com/sheets/[YOUR-SHEET-ID-HERE]     

    #### returns a map
    https://pure-brushlands-4880.herokuapp.com/sheets/[YOUR-SHEET-ID-HERE]/map 

##Future plans

1. Support for WKT in addition to latitude and longitude in Google spreadsheets. This would allow one to render more complex shapes like lines and polygons
2. Refactor sheet model methods and pretty much everything else

##Contribute

To contribute, fork this repository. To run locally, clone, bundle install, rake db:migrate
