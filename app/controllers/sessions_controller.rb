class SessionsController < ApplicationController

	def new
		if signed_in?
			redirect_to formularios_path
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
      redirect_to formularios_path
		else
			flash.now[:error] = "Email/Contrasena Invalida"
			render 'new'
		end
	end
end
