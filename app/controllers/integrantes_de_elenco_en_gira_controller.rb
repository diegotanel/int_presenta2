#encoding: utf-8
class IntegrantesDeElencoEnGiraController < ApplicationController
  before_action :signed_in_user, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :inicializar_variables, only: [:new, :edit]

  def show
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteDeElencoEnGira.find(params[:id])
  end

  def new
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @val_max_2_tecnicos = @formulario.elenco_en_gira.maximo_dos_tecnicos
    @val_max_3_directores = @formulario.elenco_en_gira.maximo_tres_directores
    @val_max_3_entre_los_dos = @formulario.elenco_en_gira.combinacion_director_tecnico
    @integrante = IntegranteDeElencoEnGira.new
    @nacionalidad_integrante = NacionalidadIntegrante.new
  end

  def edit
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @val_max_2_tecnicos = @formulario.elenco_en_gira.maximo_dos_tecnicos
    @val_max_3_directores = @formulario.elenco_en_gira.maximo_tres_directores
    @val_max_3_entre_los_dos = @formulario.elenco_en_gira.combinacion_director_tecnico
    @integrante = IntegranteDeElencoEnGira.find(params[:id])
  end

  def create
    @formulario = Formulario.find_by_id(params[:formulario_id])

    unless @formulario.elenco_en_gira
      @elenco = @formulario.build_elenco_en_gira
      @elenco.saltear_validaciones_de_presencia = true
      @elenco.save!
    end

    @integrante = @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.build(integrante_de_elenco_en_gira_params)
    @integrante.saltear_validaciones_de_presencia = true
    
    nacionalidad_factory(@integrante, nacionalidad_integrante_params)

    if @formulario.elenco_en_gira.integrantes_de_elenco_en_gira << @integrante
      flash[:success] = "Se ha creado un integrante correctamente"
      redirect_to formulario_elencos_en_gira_path
    else
      agregar_errores_de_nacionalidad(@integrante)
      inicializar_variables
      render 'new'
    end
  end

  def update
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @integrante = IntegranteDeElencoEnGira.find(params[:id])
    @formulario.elenco_en_gira.saltear_validaciones_de_presencia = true
    @integrante.saltear_validaciones_de_presencia = true

    @nacionalidad_integrante = nacionalidad_factory(@integrante, nacionalidad_integrante_params)
    @integrante.save

    if @integrante.update(integrante_de_elenco_en_gira_params)
      flash[:success] = "Se ha actualizado un integrante correctamente"
      redirect_to formulario_elencos_en_gira_path
    else      
      agregar_errores_de_nacionalidad(@integrante)
      inicializar_variables
      render 'edit'
    end
  end

  def destroy
    @formulario = Formulario.find_by_id(params[:formulario_id])
    @formulario.elenco_en_gira.saltear_validaciones_de_presencia = true
    if @formulario.elenco_en_gira.integrantes_de_elenco_en_gira.destroy(params[:id])
      flash[:success] = "Se ha eliminado el integrante correctamente"
      redirect_to formulario_elencos_en_gira_path
    else
      flash.now[:failure] = "El integrante no pudo ser eliminado"
      render 'index'
    end
  end

  def pegar_form_parcial_nacionalidad
        partial = params[:partial_name]
        render( :partial => partial )                                  
  end

  private

  # def integrante_de_elenco_en_gira_params
  #     params.require(:integrante_de_elenco_en_gira).permit(:provincia_id, :localidad_id, :nombre, :apellido, :cuil_cuit, "fecha_de_nacimiento(3i)", "fecha_de_nacimiento(2i)", "fecha_de_nacimiento(1i)", :fecha_de_nacimiento,:calle, :altura_calle, :piso, :depto, :codigo_postal, :tel_particular, :prefijo_tel_part, :prefijo_tel_cel, :tel_celular, :email, :nacionalidad_integrante , :integrante_rol_ids => [])
  # end

  def integrante_de_elenco_en_gira_params      
    #params.require(:transferencia).permit(:fecha, :area_id, :deposito_id)
    params.require(:integrante_de_elenco_en_gira).permit! 
  end

  def nacionalidad_integrante_params
    params.require(:nacionalidad_integrante).permit! 
  end


  def inicializar_variables
    @provincias = Provincia.all
    @region = Region.all
    @localidades = Localidad.all
    @integrante_roles = IntegranteRol.all
    @nacionalidades = Nacionalidad.order(:detalle)
  end

  def es_nacional?(nacionalidad_id)
    #Id de la Nacionalidad Argentina
    nacional_id = 7
    nacional_id.eql?(nacionalidad_id)
  end

  def agregar_errores_de_nacionalidad(integrante)
    nacionalidad = integrante.nacionalidad_integrante
    if !nacionalidad.nil? && !nacionalidad.procedencia.nil? 
      nacionalidad.procedencia.errors.full_messages.each do |error| 
        integrante.errors.add(:base, error)
      end
    end
  end

  def nacionalidad_selecionada?(nacionalidad_integrante_params)
    !nacionalidad_integrante_params['nacionalidad_id'].blank?
  end

  def nacionalidad_factory(integrante, nacionalidad_integrante_params)
    if nacionalidad_selecionada?(nacionalidad_integrante_params)
      integrante.nacionalidad_integrante.destroy if integrante.nacionalidad_integrante

      nacionalidad_id = nacionalidad_integrante_params['nacionalidad_id'].to_i
      nacionalidad_integrante = integrante.build_nacionalidad_integrante(nacionalidad_id: nacionalidad_id)

      if es_nacional?(nacionalidad_id)
        nacionalidad_integrante.procedencia = Nacional.create(cuil_cuit: nacionalidad_integrante_params['nacionales']['cuil_cuit'])
      else
        nacionalidad_integrante.procedencia = Extranjero.create(tipo_doc: nacionalidad_integrante_params['extranjeros']['tipo_doc'] , num_doc: nacionalidad_integrante_params['extranjeros']['num_doc'])
      end
    end
  end
end