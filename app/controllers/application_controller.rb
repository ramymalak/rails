class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


helper_method :current_user


def myauth
		if current_user != nil
		      #super
		else
		      redirect_to log_in_path, :notice => 'if you want to add a notice'

		end
end

private

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

end


