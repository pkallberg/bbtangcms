# Be sure to restart your server when you modify this file.

BBTangCMS::Application.config.session_store :cookie_store, key: '_BBTangCMS_session', :expire_after => 86400*90

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# BBTangCMS::Application.config.session_store :active_record_store
