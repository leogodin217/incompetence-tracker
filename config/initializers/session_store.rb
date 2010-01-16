# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_incompetence-tracker_session',
  :secret      => '5375a901f29e7d5a7140152d38a02ead967cd95b90abc9728cd4662fc4227a8dcdb5725107c2aa58bfe1b32b4e58a4917fca790481e8138b3bad2de543078a02'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
