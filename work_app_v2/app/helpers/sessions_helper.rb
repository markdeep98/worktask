module SessionsHelper

	#осуществить вход пользователя
	def log_in(user)
		session[:user_id] = user.id
	end


	# Возвращает true, если заданный пользователь является текущим.
def current_user?(user)
user == current_user
end

# Возвращает пользователя, соответствующего remember-токену в куки.
def current_user
	if (user_id = session[:user_id])
		@current_user ||= User.find_by(id: user_id)
	elsif (user_id = cookies.signed[:user_id])
		user = User.find_by(id: user_id)
	if user && user.authenticated?(cookies[:remember_token])
		log_in user
		@current_user = user
		end
	end
end

	
	#нужно для того чтобы менять ссылкы для вошедших и невошедших пользователей
	def logged_in?
		!current_user.nil?
	end

	  # Осуществляет выход текущего пользователя.
  	def log_out
	    session.delete(:user_id)
	    @current_user = nil
  	end
	
end
