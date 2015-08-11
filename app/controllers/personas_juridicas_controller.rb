class PersonasJuridicasController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.find(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.new(persona_juridica_params)
    @persona_juridica.saltear_validaciones_de_presencia = true
    if @persona_juridica.save
      @formulario.responsable.destroy if @formulario.responsable
      @responsable = @formulario.build_responsable
      @responsable.responsabilidad = @persona_juridica
      if @responsable.save
        flash[:success] = "Datos de la persona juridica correctamente creados"
        redirect_to formulario_integrantes_comision_directiva_path
      end
    else
      inicializar_variables
      render 'new'
    end
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.find(params[:id])
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_juridica = PersonaJuridica.find(params[:id])
    @persona_juridica.saltear_validaciones_de_presencia = true
    if @persona_juridica.update_attributes(persona_juridica_params)
      flash[:success] = "Datos de la persona juridica actualizados"
      redirect_to formulario_integrantes_comision_directiva_path
    else
      inicializar_variables
      render 'edit'
    end
  end

  def destroy
    @formulario = Formulario.find_by_id(params[:formulario_id])
    if @formulario.responsable.destroy
      flash[:success] = "Se ha eliminado el responsable"
      redirect_to edit_formulario_path(@formulario)
    else
      flash.now[:failure] = "El responsable no pudo ser eliminado"
      redirect_to edit_formulario_path(@formulario)
    end
  end

  private

  def persona_juridica_params
    params.require(:persona_juridica).permit(:nombre_per_juridica, :num_cuit, :num_per_juridica, :calle, 
       :altura_calle, :localidad_id, :codigo_postal, :email_entidad, :tel_entidad)
  end

  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
  end
end