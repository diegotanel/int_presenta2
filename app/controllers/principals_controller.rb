class PrincipalsController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]


  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @principal = Principal.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @principal = Principal.find(params[:id])
  end

  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@principal = @formulario.build_principal(principal_params)
    @principal.saltear_validaciones_de_presencia = true
    if @principal.save
      flash[:success] = "Datos principales correctamente creados"
      redirect_to formulario_principal_path(@formulario, @principal)
    else
    	inicializar_variables
      render 'new'
    end
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @principal = Principal.find(params[:id])
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @principal = Principal.find(params[:id])
    @principal.saltear_validaciones_de_presencia = true
    if @principal.update_attributes(principal_params)
      flash[:success] = "Datos principales actualizados"
      redirect_to formulario_principal_path(@formulario, @principal)
    else
      inicializar_variables
      render 'edit'
    end
  end

  def obtener_region
    @provincia = Provincia.find(params[:provincia_id])
    @region = @provincia.region
    respond_to do | format |
      format.js { render json: @region }
    end
  end

  def obtener_localidad
    @provincia = Provincia.find(params[:provincia_id])
    @localidad = @provincia.localidad
    respond_to do | format |
      format.js { render json: @localidad }
    end
  end

  def errores
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @principal = Principal.find(params[:id])
  end

  private

  def principal_params
    params.require(:principal).permit(:localidad_id, :grupo_id, :nombre, :nombre_contacto, :apellido_contacto, :email_contacto, :tel_particular, :prefijo_tel_part, :tel_celular, :prefijo_tel_cel)
  end

  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
    @grupos = Grupo.all
  end
end
