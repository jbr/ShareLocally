# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sharelocally_session',
  :secret      => 'ef1d5caeb76cbd2e63a78e994db4a391e76865aa40a40dc7576d7081eeddfcbb0740e784428bbf1dcfabcc04b22e74ba67a12b8893e86d993bd98fd5666cbcb5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
