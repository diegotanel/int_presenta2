class FormulariosTerminadosController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
   @formulario = Formulario.find_by_id(params[:formulario_id])
   @formulario.estado = Formulario::ESTADOS[:enviado]
   @formulario.created_at = Time.now
   @formulario.updated_at = Time.now
   @formulario.save!
  end
end
