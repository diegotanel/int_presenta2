class PersonasFisicasEIntController < ApplicationController
	before_action :signed_in_user, only: [:new, :show, :create, :edit, :update, :index, :vista]
  before_action :inicializar_variables, only: [:new, :create, :vista]

  def new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = IntegranteDeElencoEnGira.find_by_id(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = IntegranteDeElencoEnGira.find_by_id(params[:buscado_id])
    @persona_fisica_e_int = PersonaFisicaEInt.new
    @persona_fisica_e_int.integrante_de_elenco_en_gira_id = @buscado.id
    if @persona_fisica_e_int.save
      @formulario.responsable.destroy if @formulario.responsable
      @responsable = @formulario.build_responsable
      @responsable.responsabilidad = @persona_fisica_e_int
      if @responsable.save
        flash[:success] = "Datos de la persona fisica correctamente creados"
        redirect_to vista_formulario_persona_fisica_e_int_path(@formulario, @persona_fisica_e_int)
      else
        flash[:error] = "Hubo un problema, intentelo nuevamente"
        redirect_to new_formulario_persona_juridica_e_path(@formulario)
      end
    else
      inicializar_variables
      render 'new'
    end
  end

  def vista
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @id_integrante = @formulario.responsable.responsabilidad.integrante_de_elenco_en_gira_id
    @persona_fisica_e_int = IntegranteDeElencoEnGira.find_by_id(@id_integrante)
  end

  private

  def inicializar_variables
    @integrantes = IntegranteDeElencoEnGira.all
  end
end
