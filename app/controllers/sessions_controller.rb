class SessionsController < ApplicationController
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
      render json: {error: "Author is not logged in or could not be found."}, status: :unauthorized
    end
  end

  def destroy
    if logged_in?
      # Clear the user's token (assuming you store tokens in the database)
      current_author.update(token: nil)

      # Clear the session
      session.delete(:author_id)
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
end
