# Be sure to restart your server when you modify this file.

# FinalTask::Application.config.session_store :encrypted_cookie_store, key: '_final_task_session'
FinalTask::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 2.days
