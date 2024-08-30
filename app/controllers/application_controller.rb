class ApplicationController < ActionController::API
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
  
      before_action :cors_preflight_check, if: -> { request.method == 'OPTIONS' }
  
    private
  
    def cors_preflight_check
      headers['Access-Control-Allow-Origin'] = 'https://suharacontainerhandler.netlify.app'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Max-Age'] = '600'
      head :ok
    end
end
