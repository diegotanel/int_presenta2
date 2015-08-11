class DatosEspsController < ApplicationController
  before_action :inicializar_variables, only: [:new, :edit]
  before_action :signed_in_user, only: [:new, :show, :create, :edit, :update]

	def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsp.new
  end

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsp.find(params[:id])
  end

  def create
  	@formulario = Formulario.find_by_id(params[:formulario_id])
  	@datos_esp = @formulario.build_datos_esp(datos_esp_params)
    @datos_esp.saltear_validaciones_de_presencia = true
    if @datos_esp.save
      flash[:success] = "Datos del espectaculo correctamente creados"
      redirect_to formulario_ficha_artisticas_path
    else
      inicializar_variables
      render 'new'
    end
  end

  def edit
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsp.find(params[:id])
  end

  def update
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsp.find(params[:id])
    @datos_esp.saltear_validaciones_de_presencia = true
    if @datos_esp.update_attributes(datos_esp_params)
      flash[:success] = "Datos del espectaculo actualizados"
      redirect_to formulario_ficha_artisticas_path
    else
      render 'edit'
    end
  end

  def errores
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @datos_esp = DatosEsp.find(params[:id])
  end
  
  private

	 def datos_esp_params
	  params.require(:datos_esp).permit(:fecha_de_estreno, :nombre_autor, :nacionalidad_autor, :duracion_espectaculo, :sinopsis_obra, 
      :pagina_web, :facebook, :twitter, :blog, :youtube, :instagram, :imagen, :autorizacion_del_autor, :gen_esp_ids => [], :publ_edad_ids => [], :publ_exp_ids => [], :formato_ids => [])
	 end

  def inicializar_variables
    @gen_esps = GenEsp.all
    @publs_exp = PublExp.all
    @publs_edad = PublEdad.all
    @formatos = Formato.all
  end
end