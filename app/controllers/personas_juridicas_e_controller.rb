class PersonasJuridicasEController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update, :index, :vista]
  before_action :inicializar_variables, only: [:new, :create, :buscar_integrante_por_cuit, :vista]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica_e = PersonaJuridicaE.new
  end

  def buscar_juridica_por_cuit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = nil
    @buscado = PersonaJuridica.where(num_cuit: params[:numero_cuit])[0]
    if @buscado.nil?
      flash[:error] = "No se encontro a ninguna persona con ese cuit. Cree una nueva"
      render 'new'
    else
      flash[:success] = "Se encontro a una persona juridica con ese cuit"
      redirect_to formulario_persona_juridica_e_path(@formulario, @buscado)
    end
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = PersonaJuridica.find_by_id(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = PersonaJuridica.find_by_id(params[:buscado_id])
    @persona_juridica_e = PersonaJuridicaE.new
    @persona_juridica_e.persona_juridica_id = @buscado.id
    if @persona_juridica_e.save
      @formulario.responsable.destroy if @formulario.responsable
      @responsable = @formulario.build_responsable
      @responsable.responsabilidad = @persona_juridica_e
      if @responsable.save
        flash[:success] = "Datos de la persona fisica correctamente creados"
        redirect_to vista_formulario_persona_juridica_e_path(@formulario, @persona_juridica_e)
      else
        flash[:error] = "Hubo un problema, intentelo nuevamente"
        redirect_to new_formulario_persona_juridica_e_path(@formulario)
      end
    else
      inicializar_variables
      render 'new'
    end
  end

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @buscado = PersonaJuridica.find_by_id(params[:id])
    @persona_juridica_e = @formulario.responsable.build_responsabilidad(persona_juridica_id: @buscado.id)
    if @persona_juridica_e.save
      @formulario.responsable.destroy if @formulario.responsable
      @responsable = @formulario.build_responsable
      @responsable.responsabilidad = @persona_juridica_e
      if @responsable.save
        flash[:success] = "Datos de la persona fisica correctamente creados"
        redirect_to vista_formulario_persona_juridica_e_path(@formulario, @responsable)
      end
    else
      flash[:error] = "Hubo un problema, intentelo nuevamente"
      redirect_to new_formulario_persona_juridica_e_path(@formulario)
    end
  end

  def vista
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @id_juridica = @formulario.responsable.responsabilidad.persona_juridica_id
    @persona_juridica_e = PersonaJuridica.find_by_id(@id_juridica)
  end

  private

  def inicializar_variables
    @juridicas = PersonaJuridica.all
  end
end
