#encoding: utf-8

class PasswordRecoversController < ApplicationController

  def new
  end

  def create
  	@user = User.find_by(email: params[:password_recover][:email])
  	if @user
  		UserMailer.password_recover(@user).deliver
  		flash[:success] = "Email enviado con su contraseña"
      redirect_to root_url
  	else
  		flash[:error] = "No se ha encontrado ningún usuario con esa dirección de correo electrónico." 
  		render 'new'
  	end
  end
end
