# config/initializers/firebase.rb

def initialize_firebase
    require 'firebase_admin_sdk'
    
    # Load service account credentials
    service_account_path = Rails.root.join('config', 'suharadelaychater-firebase-adminsdk-59036-aff6b81772.json')
    service_account = JSON.parse(File.read(service_account_path))
    
    # Initialize Firebase Admin SDK
    @firebase = FirebaseAdmin::App.new(service_account)
    
    @firebase
  end
  
  # Call the method to initialize Firebase when the Rails app starts
  initialize_firebase
  