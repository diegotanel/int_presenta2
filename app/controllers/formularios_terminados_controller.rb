class FormulariosTerminadosController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
  	@formulario = Formulario.find_by_id(params[:formulario_id])
    @coincidencia1 = nombre_espectaculo_repetido(params[:formulario_id])
    @coincidencia2 = provincia_repetida(@coincidencia1, params[:formulario_id])
    @coincidencia3 = localidad_repetida(@coincidencia2, params[:formulario_id])
    @coincidencia4 = responsable_repetido(@coincidencia3, params[:formulario_id])
    if @coincidencia4.empty?
      @formulario.estado = Formulario::ESTADOS[:enviado]
    	@formulario.created_at = Time.now
    	@formulario.updated_at = Time.now
    	@ultimo_form = Formulario.find_by_estado(1)
    	if @ultimo_form.nil?
    		@formulario.num_tramite = 1
    	else
    		@formulario.num_tramite = @ultimo_form.num_tramite + 1
    	end
     	@formulario.save!
    end
  end

  def nombre_espectaculo_repetido(formulario_id)
    @formularios_con_mismo_nombre = []
    @formulario = Formulario.find_by_id(formulario_id)
    @formularios = Formulario.where(estado: 1)
    for form in @formularios
      if form.principal.nombre == @formulario.principal.nombre
        @formularios_con_mismo_nombre << form
      end
    end
    return @formularios_con_mismo_nombre
  end

  def provincia_repetida(formularios, formulario_id)
    @formularios_con_misma_provincia_y_nombre = []
    @formulario = Formulario.find_by_id(formulario_id)
    for form in formularios
      if form.principal.provincia.id == @formulario.principal.provincia.id
        @formularios_con_misma_provincia_y_nombre << form
      end
    end
    return @formularios_con_misma_provincia_y_nombre
  end

  def localidad_repetida(formularios, formulario_id)
    @formularios_con_misma_localidad_provincia_y_nombre
    @formulario = Formulario.find_by_id(formulario_id)
    for form in formularios
      if form.principal.localidad.id == @formulario.principal.localidad.id
        @formularios_con_misma_localidad_provincia_y_nombre << form
      end
    end
    return @formularios_con_misma_localidad_provincia_y_nombre
  end

  def responsable_repetido(formularios, formulario_id)
    @formularios_con_mismo_responsable_localidad_provincia_y_nombre = []
    @formulario = Formulario.find_by_id(formulario_id)
    for form in formularios
      if form.responsable.responsablidad_type == "PersonaJuridica" and @formulario.responsable.responsablidad_type == "PersonaJuridica"
        if form.responsable.responsabilidad.num_cuit == @formulario.responsable.responsabilidad.num_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaJuridicaE" and @formulario.responsable.responsablidad_type == "PersonaJuridicaE"
        if form.responsable.responsabilidad.persona_juridica_id == @formulario.responsable.responsablidad.persona_juridica_id
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaENue" and @formulario.responsable.responsablidad_type == "PersonaFisicaENue"
        if form.responsable.responsabilidad.persona_fisica_n_id == @formulario.responsable.responsablidad.persona_fisica_n_id
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaEInt" and @formulario.responsable.responsablidad_type == "PersonaFisicaEInt"
        if form.responsable.responsabilidad.integrante_de_elenco_en_gira_id == @formulario.responsable.responsablidad.integrante_de_elenco_en_gira_id
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaN" and @formulario.responsable.responsablidad_type == "PersonaFisicaN"
        if form.responsable.responsabilidad.cuil_cuit == @formulario.responsable.responsablidad.cuil_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaJuridica" and @formulario.responsable.responsablidad_type == "PersonaJuridicaE"
        @id_juridica = @formulario.responsable.responsabilidad.persona_juridica_id
        @persona_juridica_e = PersonaJuridica.find_by_id(@id_juridica)
        if form.responsable.responsabilidad.num_cuit == @persona_juridica_e.num_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaJuridicaE" and @formulario.responsable.responsablidad_type == "PersonaJuridica"
        @id_juridica = form.responsable.responsabilidad.persona_juridica_id
        @persona_juridica_e = PersonaJuridica.find_by_id(@id_juridica)
        if @persona_juridica_e.num_cuit == @formulario.responsable.responsabilidad.num_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaENue" and @formulario.responsable.responsablidad_type == "PersonaFisicaN"
        @id_persona_fisica = form.responsable.responsabilidad.persona_fisica_n_id
        @persona_fisica_e_nue = PersonaFisicaN.find_by_id(@id_persona_fisica)
        if @persona_fisica_e_nue.num_cuit == @formulario.responsable.responsablidad.cuil_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaN" and @formulario.responsable.responsablidad_type == "PersonaFisicaENue"
        @id_persona_fisica = @formulario.responsable.responsabilidad.persona_fisica_n_id
        @persona_fisica_e_nue = PersonaFisicaN.find_by_id(@id_persona_fisica)
        if form.responsable.responsabilidad.num_cuit == @persona_fisica_e_nue.cuil_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaEInt" and @formulario.responsable.responsablidad_type == "PersonaFisicaN"
        @id_integrante = form.responsable.responsabilidad.integrante_de_elenco_en_gira_id
        @persona_fisica_e_int = IntegranteDeElencoEnGira.find_by_id(@id_integrante)
        if @persona_fisica_e_int.num_cuit == @formulario.responsable.responsablidad.cuil_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaN" and @formulario.responsable.responsablidad_type == "PersonaFisicaEInt"
        @id_integrante = @formulario.responsable.responsabilidad.integrante_de_elenco_en_gira_id
        @persona_fisica_e_int = IntegranteDeElencoEnGira.find_by_id(@id_integrante)
        if form.responsable.responsabilidad.num_cuit == @persona_fisica_e_int.cuil_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaEInt" and @formulario.responsable.responsablidad_type == "PersonaFisicaENue"
        @id_integrante = form.responsable.responsabilidad.integrante_de_elenco_en_gira_id
        @persona_fisica_e_int = IntegranteDeElencoEnGira.find_by_id(@id_integrante)
        @id_persona_fisica = @formulario.responsable.responsabilidad.persona_fisica_n_id
        @persona_fisica_e_nue = PersonaFisicaN.find_by_id(@id_persona_fisica)
        if @persona_fisica_e_int.num_cuit == @persona_fisica_e_nue.cuil_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
      if form.responsable.responsablidad_type == "PersonaFisicaENue" and @formulario.responsable.responsablidad_type == "PersonaFisicaEInt"
        @id_persona_fisica = form.responsable.responsabilidad.persona_fisica_n_id
        @persona_fisica_e_nue = PersonaFisicaN.find_by_id(@id_persona_fisica)
        @id_integrante = @formulario.responsable.responsabilidad.integrante_de_elenco_en_gira_id
        @persona_fisica_e_int = IntegranteDeElencoEnGira.find_by_id(@id_integrante)
        if @persona_fisica_e_nue.num_cuit == @persona_fisica_e_int.cuil_cuit
          @formularios_con_mismo_responsable_localidad_provincia_y_nombre << form
        end
      end
    end
    return @formularios_con_mismo_responsable_localidad_provincia_y_nombre
  end

  def director_repetido(formularios, formulario_id)
    @directores = []
    @directores_formulario = []
    @formularios_con_mismo_director_localidad_provincia_y_nombre = []
    @formulario = Formulario.find_by_id(formulario_id)
    for integrante_formulario in @formulario.elenco_en_gira.integrantes_de_elenco_en_gira
      if integrante_formulario.integrante_roles.ids.include?(2)
        @directores_formulario << integrante_formulario
      end
    end
    for form in formularios
      for integrante in form.elenco_en_gira.integrantes_de_elenco_en_gira
        if integrante.integrante_roles.ids.include?(2)
            @directores << integrante
          end
        end
      end
    end
    for director in @directores
      for director_formulario in @directores_formulario
        if director.nacionalidad_integrante.procedencia_type == director_formulario.nacionalidad_integrante.procedencia_type
          if director.nacionalidad_integrante.procedencia_type == "Nacional" and director.nacionalidad_integrante.procedencia.cuil_cuit == director_formulario.nacionalidad_integrante.procedencia.cuil_cuit
            coincidencia = 1
          end
          if director.nacionalidad_integrante.procedencia_type == "Extranjero" and director.nacionalidad_integrante.procedencia.num_doc == director_formulario.nacionalidad_integrante.procedencia.num_doc
            coincidencia = 1
          end
        end
      end
    end
    return coincidencia
  end
end
