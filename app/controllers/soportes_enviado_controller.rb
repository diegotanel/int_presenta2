class SoportesEnviadoController < ApplicationController
  before_action :signed_in_user, only: [:index]
  before_action :admin_user, only: [:index]

  def index
    @p = Formulario.search(params[:p])
    @formularios = @p.result.includes(:formularios, :principals, :provincias, :regiones, :datos_esps, :datos_grupos, :datos_tecs, :responsables, :fichas_artisticas, :elenco_en_gira)
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin? or current_user.jurado?
  end
end
