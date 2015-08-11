class PersonasFisicasENueController < ApplicationController
	before_action :signed_in_user, only: [:new, :show, :create, :vista]
  before_action :inicializar_variables, only: [:new, :create, :vista]
  
  def new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = PersonaFisicaN.find_by_id(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = PersonaFisicaN.find_by_id(params[:buscado_id])
    @persona_fisica_e_nue = PersonaFisicaENue.new
    @persona_fisica_e_nue.persona_fisica_n_id = @buscado.id
    if @persona_fisica_e_nue.save
      @formulario.responsable.destroy if @formulario.responsable
      @responsable = @formulario.build_responsable
      @responsable.responsabilidad = @persona_fisica_e_nue
      if @responsable.save
        flash[:success] = "Datos de la persona fisica correctamente creados"
        redirect_to vista_formulario_persona_fisica_e_nue_path(@formulario, @persona_fisica_e_nue)
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
    @id_persona_fisica = @formulario.responsable.responsabilidad.persona_fisica_n_id
    @persona_fisica_e_nue = PersonaFisicaN.find_by_id(@id_persona_fisica)
  end

  private

  def inicializar_variables
    @personas_fisicas = PersonaFisicaN.all
  end
end
