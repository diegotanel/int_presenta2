#encoding: utf-8
class SuperVistasController < ApplicationController
	before_action :signed_in_user, only: [:index]

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
  end
end