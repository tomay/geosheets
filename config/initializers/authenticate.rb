# authenticate.rb
# custom initializer to get the Google Drive session

# load env variables
Dotenv.load
# then get the token and initiate a session
access_token = GoogleOauth2Installed.access_token

# return session on Rails.config
Rails.configuration.session = GoogleDrive.login_with_oauth(access_token)
