class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Question created"
			redirect_to root_url
		else
			flash[:danger] = "Ask a question please"
			@feed_items = []
			redirect_to root_url
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "Question deleted"
		redirect_to request.referrer || root_url #перенаправить на предыдущую стр. или на главную
	end

	def edit
      @micropost = Micropost.find(params[:id])
    end

	def update
      @micropost = Micropost.find(params[:id])
      if @micropost.update_attributes(micropost_params)
        flash[:success] = "Your question has been updated successfully"
        redirect_to root_url
      else
        render 'edit'
      end
    end

	private

	def micropost_params
		params.require(:micropost).permit(:content)
	end

	def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end	

