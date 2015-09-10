class PersonasFisicasEController < ApplicationController
  before_action :signed_in_user, only: [:new, :buscar_persona_por_cuil_cuit]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
  end

  def buscar_persona_por_cuil_cuit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @nacional = Nacional.where(cuil_cuit: params[:numero_cuil_cuit])[0]
    @buscado = @nacional.nacionalidad_integrante.integrante_de_elenco_en_gira
    if @buscado.nil?
      @buscado = PersonaFisicaN.where(cuil_cuit: params[:numero_cuil_cuit])[0]
      if @buscado.nil?
        flash[:error] = "No se encontro a ninguna persona con ese cuil o cuit. Cree una nueva"
        render 'new'
      else
        redirect_to formulario_persona_fisica_e_nue_path(@formulario, @buscado)
      end
    else
      if @buscado.es_menor?
        flash[:error] = "No es posible seleccionar el integrante por ser menor"
        render 'new'
      else
        flash[:success] = "Se encontro a un integrante con ese cuil/cuit"
        redirect_to formulario_persona_fisica_e_int_path(@formulario, @buscado)
      end
    end
  end
end