# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_war-for-newerth_session',
  :secret      => 'd2a14ca43e47991fd46d5597d1e851f01a7730bf87900068603c3f52a1f1993583735534742725ef33772e82768f5bfe4881e24eddd2cd2f5e229dc9f45c1f94'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
