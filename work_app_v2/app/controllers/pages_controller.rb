class PagesController < ApplicationController
	def home
		if logged_in?
			@micropost = current_user.microposts.build
			@user = current_user
			@microposts = Micropost.all.paginate(page: params[:page], :per_page => 5)
		end
	end
end
