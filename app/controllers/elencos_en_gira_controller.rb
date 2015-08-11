class ElencosEnGiraController < ApplicationController
  before_action :signed_in_user, only: [:index, :show]

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @formulario.create_elenco_en_gira() unless @formulario.elenco_en_gira
    @integrantes = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira ? @formulario.elenco_en_gira.integrantes_de_elenco_en_gira : []
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrantes = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira ? @formulario.elenco_en_gira.integrantes_de_elenco_en_gira : []
  end

  def errores
    @formulario = Formulario.find_by_id(params[:formulario_id])
  end

  private

end
