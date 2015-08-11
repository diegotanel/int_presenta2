#encoding: utf-8
class IntegrantesComisionDirectivaController < ApplicationController
  before_action :signed_in_user, only: [:show, :new, :edit, :create, :update, :destroy, :index]
  before_action :inicializar_variables, only: [:new, :edit]

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteComisionDirectiva.find(params[:id])
  end

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    if @formulario.responsable.responsabilidad.integrantes_comision_directiva.count == 5
      flash[:error] = "No puede tener mas de 5 integrantes"
      redirect_to formulario_integrantes_comision_directiva_path
    else
      @integrante = IntegranteComisionDirectiva.new(params[:id])
    end
  end

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrantes = []
    @integrantes_comision = @formulario.responsable.responsabilidad.integrantes_comision_directiva
    @integrantes = [@integrantes_comision]
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteComisionDirectiva.find(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteComisionDirectiva.new(integrante_comision_directiva_params)
    @integrante.saltear_validaciones_de_presencia = true
    if @formulario.responsable.responsabilidad.integrantes_comision_directiva << @integrante
      flash[:success] = "Se ha creado un nuevo integrante a la comision correctamente"
      redirect_to formulario_integrantes_comision_directiva_path
    else
      inicializar_variables
      render 'new'
    end
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteComisionDirectiva.find(params[:id])
    if @integrante.update(integrante_comision_directiva_params)
      flash[:success] = "Se ha actualizado una ficha correctamente"
      redirect_to formulario_integrantes_comision_directiva_path
    else
      inicializar_variables
      render 'edit'
    end
  end

  def destroy
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @formulario.responsable.responsabilidad.integrantes_comision_directiva.destroy(params[:id])
    if @formulario.responsable.save
      flash[:success] = "Se ha eliminado un integrante de la comision directiva correctamente"
      redirect_to formulario_integrantes_comision_directiva_path
    else
      flash.now[:failure] = "El integrante no puede ser eliminado"
      render 'index'
    end
  end

  private

  def integrante_comision_directiva_params
    params.require(:integrante_comision_directiva).permit(:cargo, :nombre, :apellido, :cuil_cuit, :fecha_de_nacimiento, :calle, :altura_calle, :localidad_id, :codigo_postal, :email, :tel_particular, :tel_celular)
  end

  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
  end
end
