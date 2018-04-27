module SessionsHelper

	#осуществить вход пользователя
	def log_in(user)
		session[:user_id] = user.id
	end

	#возвращает вошедшего пользователя (если есть)
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
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
