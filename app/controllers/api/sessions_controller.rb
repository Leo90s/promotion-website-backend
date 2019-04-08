module Api
  class SessionsController < BaseController
    def login
      account = params[:account]
      password = params[:password]
      user = User.find_by(account: account)

      if user && user.authenticate(password)
        render_data user
      else
        render_error('无效的账户或密码')
      end
    end
  end
end
