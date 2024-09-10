class SessionsController < ApplicationController
  before_action :initialize_firebase

  def create
    author = Author.find_by(name: session_params[:name])
    puts "Author found: #{author.inspect}"  # Debugging line

    if author && author.authenticate(session_params[:password])
      token = issue_token(author)
      puts "Token issued: #{token}"  # Debugging line
      
      # Store the user's email in the session
      session[:user_email] = author.email
      session[:author_id] = author.id

      render json: { author: AuthorSerializer.new(author), jwt: token }
    else
      puts "Authentication failed"  # Debugging line
      render json: { error: "Incorrect name or password." }, status: :unauthorized
    end

    Rails.logger.info "Reached the create action"
  end

  def show
    if logged_in?
      render json: current_author
    else
      render json: { error: "Author is not logged in or could not be found." }, status: :unauthorized
    end
  end

  def destroy
    if logged_in?
      # Clear the user's token (assuming you store tokens in the database)
      current_author.update(token: nil)

      # Clear the session
      session.delete(:author_id)
      session.delete(:name)
      session.delete(:user_email)  # Clear the stored email from the session
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { error: 'Not logged in' }, status: :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end

  def issue_token(author)
    JWT.encode({ author_id: author.id }, 'your_secret_key', 'HS256')
  end

  def decoded_token
    if request.headers['Authorization']
      token = request.headers['Authorization'].split(' ')[1]
      begin
        JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in?
    !!current_author
  end

  def current_author
    if decoded_token
      author_id = decoded_token[0]['author_id']
      @current_author ||= Author.find_by(id: author_id)
    end
  end

  def login
    user = Author.find_by(email: params[:email]) # Adjust according to your model
  
    if user && user.authenticate(params[:password]) # Adjust according to your authentication method
      # Generate Firebase custom token
      firebase_token = @firebase.auth.create_custom_token(user.id)
  
      # Respond with Firebase token and Rails token
      render json: { firebase_token: firebase_token, jwt: issue_token(user) }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def initialize_firebase
    require 'firebase_admin_sdk'
    service_account = JSON.parse(File.read(Rails.root.join('config', 'suharadelaychater-firebase-adminsdk-59036-aff6b81772.json')))
    @firebase = FirebaseAdmin::App.new(service_account)
  end
end
