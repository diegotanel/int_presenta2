class PersonasFisicasNController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_n = PersonaFisicaN.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_n = PersonaFisicaN.find(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_n = PersonaFisicaN.new(persona_fisica_n_params)
    @persona_fisica_n.saltear_validaciones_de_presencia = true
    if @persona_fisica_n.save
      @formulario.responsable.destroy if @formulario.responsable
      @responsable = @formulario.build_responsable
      @responsable.responsabilidad = @persona_fisica_n
      if @responsable.save
        flash[:success] = "Datos de la persona fisica correctamente creados"
        redirect_to formulario_persona_fisica_n_path(@formulario, @persona_fisica_n)
      end
    else
      inicializar_variables
      render 'new'
    end
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_n = PersonaFisicaN.find(params[:id])
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @persona_fisica_n = PersonaFisicaN.find(params[:id])
    @persona_fisica_n.saltear_validaciones_de_presencia = true
    if @persona_fisica_n.update_attributes(persona_fisica_n_params)
      flash[:success] = "Datos de la persona fisica actualizados"
      redirect_to formulario_persona_fisica_n_path
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

   def persona_fisica_n_params
    params.require(:persona_fisica_n).permit(:provincia_id, :localidad_id, :nombre, :apellido, :cuil_cuit, "fecha_de_nacimiento(3i)", "fecha_de_nacimiento(2i)", "fecha_de_nacimiento(1i)", :calle, :altura_calle, :piso, :depto, :codigo_postal, :tel_particular, :tel_celular, :email)
   end

  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
  end
end