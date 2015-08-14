class FormulariosTerminadosController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@formulario.estado = Formulario::ESTADOS[:enviado]
  	@formulario.created_at = Time.now
  	@formulario.updated_at = Time.now
  	@ultimo_form = Formulario.find_by_estado(1)
  	if @ultimo_form.nil?
  		@formulario.num_tramite = 1
  	else
  		@formulario.num_tramite = @ultimo_form.num_tramite + 1
  	end
   	@formulario.save!
  end
end
