#encoding: utf-8
class GeneradorDeFormularioInterno

  def initialize
	@fecha_inicializacion = Time.zone.now.to_formatted_s(:number)
  end

	def generar_pdf(formulario)
		@integrantes = formulario.elenco_en_gira.integrantes_de_elenco_en_gira
		@integrantes_comision = nil
		@tipo_responsable = nil

		if formulario.responsable
			if (formulario.responsable.responsabilidad_type == "PersonaFisicaEInt")
				@id_persona = formulario.responsable.responsabilidad.integrante_de_elenco_en_gira_id
				@responsable = IntegranteDeElencoEnGira.find_by_id(@id_persona)
				@tipo_responsable = "Fisica"
			end

			if (formulario.responsable.responsabilidad_type == "PersonaFisicaN")
				@responsable = formulario.responsable.responsabilidad
				@tipo_responsable = "Fisica"
			end

			if (formulario.responsable.responsabilidad_type == "PersonaJuridica")
				@responsable = formulario.responsable.responsabilidad
				@integrantes_comision = @responsable.integrantes_comision_directiva
				@tipo_responsable = "Juridica"
			end

			if (formulario.responsable.responsabilidad_type == "PersonaFisicaENue")
				@id_persona = @formulario.responsable.responsabilidad.persona_fisica_n_id
				@responsable = PersonaFisicaN.find_by_id(@id_persona)
				@tipo_responsable = "Fisica"
			end

			if (formulario.responsable.responsabilidad_type == "PersonaJuridicaE")
				@id_juridica = formulario.responsable.responsabilidad.persona_juridica_id
				@responsable = PersonaJuridica.find_by_id(@id_juridica)
				@integrantes_comision =  @responsable.integrantes_comision_directiva
				@tipo_responsable = "Juridica"
			end
		end

		if @tipo_responsable == "Fisica"
			@ruta_plantilla = Rails.root.join("app/plantillas/FORMULARIO_INTERNO_INT_PRESENTA_PF.odt")
		else
			@ruta_plantilla = Rails.root.join("app/plantillas/FORMULARIO_INTERNO_INT_PRESENTA_PJ.odt")
		end

		report = ODFReport::Report.new(@ruta_plantilla) do |r|
			r.add_field("NOMBRE_DEL_ESPECTACULO", formulario.principal.nombre)
			r.add_field("NOMBRE_DEL_AUTOR", formulario.datos_esp.nombre_autor)
			r.add_field("PROVINCIA_PRINCIPAL", formulario.principal.provincia.detalle)
			r.add_field("FECHA_DE_ESTRENO", I18n.l(formulario.datos_esp.fecha_de_estreno))
			r.add_field("NOMBRE_CONTACTO"), formulario.principal.nombre_contacto)
			r.add_field("APELLIDO_CONTACTO"), formulario.principal.apellido_contacto)
			r.add_field("TELEFONOS_CONTACTO"), formulario.principal.prefijo_tel_part + " " + formulario.principal.tel_particular + "/ " + formulario.principal.prefijo_tel_cel + " " + formulario.principal.tel_celular)
			r.add_field("EMAIL_CONTACTO"), formulario.principal.email_contacto)

			if @tipo_responsable == "Fisica"
				llenado_de_persona_fisica(r, @responsable)
			else
				llenado_de_persona_juridica(r, @responsable)
			end

			r.add_table("TABLA_INT", @integrantes, :header=>true) do |s|
				s.add_column("INT_NOMBRE_APELLIDO") { |i| i.nombre + " " + i.apellido}
				s.add_column("INT_ROL") {|i| i.integrante_roles.map { |e| e.detalle }.join(", ")}
				s.add_column("INT_FECHA_DE_NACIMIENTO") { |i| I18n.l(i.fecha_de_nacimiento) }
				if i.nacionalidad_integrante.procedencia_type == "Nacional"
					s.add_column("INT_TIPO_DE_DOCUMENTO") {|i| i.nacionalidad_integrante.procedencia.cuil_cuit}
					s.add_column("INT_NUMERO_DE_DOCUMENTO") {|i| i.nacionalidad_integrante.procedencia.cuil_cuit}
				else
					s.add_column("INT_TIPO_DE_DOCUMENTO") {|i| i.nacionalidad_integrante.procedencia.tipo_doc}
					s.add_column("INT_NUMERO_DE_DOCUMENTO") {|i| i.nacionalidad_integrante.procedencia.num_doc}
				end
				s.add_column("INT_EMAIL", :email)
				s.add_column("INT_DOMICILIO") { |i| "#{i.calle } #{i.altura_calle } #{i.piso } #{i.depto }" }
				s.add_column("INT_LOCALIDAD") { |i| i.localidad.detalle }
				s.add_column("INT_PROVINCIA") { |i| i.provincia.detalle }
				s.add_column("INT_CP") { |i| i.codigo_postal }
			end
		end
		@ruta_formulario_interno_odt = Rails.root.join("public/forms_fomento/" + nombre_formulario_interno_odt)
		report.generate(@ruta_formulario_interno_odt)
		@ruta_formularios_internos = Rails.root.join("public/forms_fomento/")
		`libreoffice --headless --invisible --convert-to pdf --outdir #{@ruta_formularios_internos} #{@ruta_formulario_interno_odt}`
	end

	def nombre_formulario_interno_pdf
		nombre_formulario_interno + ".pdf"
	end

	private

	def nombre_formulario_interno_odt
		nombre_formulario_interno + ".odt"
	end

	def nombre_formulario_interno
		"formulario_interno_convocatoria_2015_" + @fecha_inicializacion
	end

	def llenado_de_persona_fisica(report, persona_fisica)
		report.add_field("APELLIDOS_FISICA", persona_fisica.apellido)
		report.add_field("NOMBRES_FISICA", persona_fisica.nombre)
		if (persona_fisica.class.name == "IntegranteDeElencoEnGira")
			report.add_field("CUIL_FISICA", persona_fisica.nacionalidad_integrante.procedencia.cuil_cuit)
		else
			report.add_field("CUIL_FISICA", persona_fisica.cuil_cuit)
		end
		report.add_field("FECHA_DE_NACIMIENTO_FISICA", I18n.l(persona_fisica.fecha_de_nacimiento))
		report.add_field("DOMICILIO_FISICA", "#{persona_fisica.calle } #{persona_fisica.altura_calle } #{persona_fisica.piso } #{persona_fisica.depto }")
		report.add_field("PROVINCIA_FISICA", persona_fisica.provincia.detalle)
		report.add_field("LOCALIDAD_FISICA", persona_fisica.localidad.detalle)
		report.add_field("CODIGO_POSTAL_FISICA", persona_fisica.codigo_postal)
		report.add_field("TELEFONOS_FISICA", "#{persona_fisica.prefijo_tel_part } #{persona_fisica.tel_particular } / #{persona_fisica.prefijo_tel_cel } #{persona_fisica.tel_celular }")
		report.add_field("CORREO_ELECTRONICO_FISICA", persona_fisica.email)
	end

	def llenado_de_persona_juridica(report, persona_juridica)
		report.add_field("DENOMINACION", persona_juridica.nombre_per_juridica)
		report.add_field("CUIT", persona_juridica.num_cuit)
		report.add_field("N_PERSONERIA_JURIDICA", persona_juridica.num_per_juridica)
		report.add_field("DOMICILIO_JURIDICA", "#{persona_juridica.calle } #{persona_juridica.altura_calle } #{persona_juridica.piso } #{persona_juridica.depto }")
		report.add_field("PROVINCIA_JURIDICA", persona_juridica.provincia.detalle)
		report.add_field("LOCALIDAD_JURIDICA", persona_juridica.localidad.detalle)
		report.add_field("CODIGO_POSTAL_JURIDICA", persona_juridica.codigo_postal)
		report.add_field("TELEFONOS_JURIDICA", persona_juridica.tel_entidad)
		report.add_field("CORREO_ELECTRONICO_JURIDICA", persona_juridica.email_entidad)

		report.add_table("TABLA_RL", @integrantes_comision, :header=>true) do |t|
			t.add_column("RL_NOMBRE_APELLIDO") { |i| i.nombre + " " + i.apellido}
			t.add_column("RL_CARGO", :cargo)
			t.add_column("RL_CUIL_CUIT", :cuil_cuit)
			t.add_column("RL_FECHA_DE_NACIMIENTO") { |i| I18n.l(i.fecha_de_nacimiento)}
			t.add_column("RL_DOMICILIO") { |i| "#{i.calle } #{i.altura_calle } #{i.piso } #{i.depto }" }
			t.add_column("RL_PROVINCIA") { |i| i.provincia.detalle }
			t.add_column("RL_LOCALIDAD") { |i| i.localidad.detalle }
			t.add_column("RL_CP", :codigo_postal)
			t.add_column("RL_TELEFONO") { |i| "#{i.tel_particular } / #{i.tel_celular }" }
			t.add_column("RL_EMAIL", :email)
		end
	end
end
