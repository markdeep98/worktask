class PagesController < ApplicationController
	def home
		if logged_in?
			@micropost = current_user.microposts.build
			@user = current_user
			@feed_items = current_user.feed
			@microposts = Micropost.all
		end
	end
end
