#encoding: utf-8

class UserMailer < ActionMailer::Base

	default from: 'intpresenta@inteatro.gov.ar'

  def password_recover(user)
  	@user = user
    mail(to: @user.email, subject: 'Recuperar Contraseña')
  end
end
