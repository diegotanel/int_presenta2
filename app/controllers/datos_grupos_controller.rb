class DatosGruposController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_grupo = DatosGrupo.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_grupo = DatosGrupo.find(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_grupo = @formulario.build_datos_grupo(datos_grupo_params)
    @datos_grupo.saltear_validaciones_de_presencia = true
    if @datos_grupo.save
      flash[:success] = "Datos del grupo correctamente creados"
      redirect_to formulario_datos_grupo_path(@formulario, @datos_grupo)
    else
      render 'new'
    end
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_grupo = DatosGrupo.find(params[:id])
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_grupo = DatosGrupo.find(params[:id])
    @datos_grupo.saltear_validaciones_de_presencia = true
    if @datos_grupo.update_attributes(datos_grupo_params)
      flash[:success] = "Datos del grupo actualizados"
      redirect_to formulario_datos_grupo_path(@formulario, @datos_grupo)
    else
      render 'edit'
    end
  end

  def errores
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_grupo = DatosGrupo.find(params[:id])
  end

  private

  def datos_grupo_params
    params.require(:datos_grupo).permit(:nombre_grupo, :historia)
  end
end
