class AuthorsController < ApplicationController
    def create
        author = Author.new(author_params)
    
        if author.save
            token = issue_token(author)
            render json: {author: authorSerializer.new(author), jwt: token}
        else
            if author.errors.messages
                render json: {error: author.errors.messages}
            else
                render json: {error: "author could not be created. Please try again."}
            end 
        end
    end
    
      def show
        author = Author.find_by(id: params[:id]);
        if author
            render json: author, status: :created
        else
            render json: { error: "Not authororized" }, status: :unauthororized
        end
    end
    
      
      def index
          author=Author.all
          render json: author
      end
    
      def profile
          render json: @author
      end
    
      
      private
    # def generate_token(author_id)
    #   payload = { author_id: author_id }
    #   secret_key = Rails.application.credentials.secret_key_base
    #   JWT.encode(payload, secret_key, 'HS256')
    # end
  
    def author_params
        params.permit(:name, :department, :password)
    end
end

