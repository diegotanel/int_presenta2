  class DatosTecsController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTec.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTec.find(params[:id])
  end

  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@datos_tec = @formulario.build_datos_tec(datos_tec_params)
    @datos_tec.saltear_validaciones_de_presencia = true
    if @datos_tec.save
      flash[:success] = "Datos tecnicos del espectaculo correctamente creados"
      redirect_to formulario_datos_tec_path(@formulario, @datos_tec)
    else
      inicializar_variables
      render 'new'
    end
  end

  def edit
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTec.find(params[:id])
  end

  def update
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTec.find(params[:id])
    @datos_tec.saltear_validaciones_de_presencia = true
    if @datos_tec.update_attributes(datos_tec_params)
      flash[:success] = "Datos tecnicos del espectaculo actualizados"
      redirect_to formulario_datos_tec_path(@formulario, @datos_tec)
    else
      render 'edit'
    end
  end

  def errores
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_tec = DatosTec.find(params[:id])
  end

  private

  def datos_tec_params
    params.require(:datos_tec).permit(:duracion_montaje, :duracion_desmontaje, :descripcion_espacio, :ancho, :alto, :profundidad, :listado_artefactos_luminicos, :listado_sonido, :otros_equipamientos, :peso_total, :volumen_total, :historia, :otras_necesidades, :imagen, :esps_esp_ids => [])
  end

  def inicializar_variables
    @esps_esps = EspsEsp.all
  end
end