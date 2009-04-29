# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_railsconf_meetup_session',
  :secret      => '758083ce33d03dfdc4b79e1dfad9f390f8587b03dc626134b9fc684a6d7a420bb7d2b932790d80f8db022171e107be949e69d737088280236cd5d9a17e20c64c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
