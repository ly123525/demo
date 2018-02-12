module API
  module Helpers
    module Common
      extend ActiveSupport::Concern
      included do
        helpers do
          def build_response code:0, data: nil
            {code: code, data: data}
          end

          def authenticate_user
            access_token =request.headers["HTTP_ACCESS_TOKEN"]
            error!("token不存在", 404)  if access_token.blank?
            @current_user=User.find_by_access_token(access_token)
            unless @current_user
              error! "用户不存在！", 404
            end
          end

        end
      end

    end
  end
end