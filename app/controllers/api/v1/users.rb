module API
  module V1
  class Users < Grape::API
    # version 'v1', using: :path
    # default_format :json
    include API::Helpers::Common

    resources :users do
      desc "获取用户信息"
      params do
        requires :id, type: Integer
      end
      get ':id' do
          authenticate_user
          build_response(data:{id: @current_user.id, email: @current_user.username})
      end

      desc "用户注册"
      params do
        requires :cellphone, type: String,regexp: /\A(\+86|86)?1\d{10}\z/
        requires :password, type: String
        requires :password_confirmation, type: String
      end
      post do
        user=User.new(cellphone: params[:cellphone],  password: params[:password], password_confirmation: params[:password_confirmation])
        if user.save
          build_response(data: 'success')
        else
          build_response(data: user.errors.messages.values.first)
        end
      end
    end

    end
  end
end