class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :authenticate_user
    before_action :authenticate_user!
    private
        def authenticate_user
            if request.headers['Authorization'].present?
                authenticate_or_request_with_http_token do |token|
                    begin
                        payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
                        @current_user_id = payload['id']
                    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
                        head :unauthorized
                    end
                end
            end
        end

        def authenticate_user!
            head :unauthorized unless signed_in?
        end

        def current_user
            @current_user ||= super || User.find(@current_user_id)
        end

        def signed_in?
            @current_user_id
        end

end
