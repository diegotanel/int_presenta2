# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

ActiveSupport::Inflector.inflections do |inflect|
	inflect.irregular 'error', 'errores'
	inflect.irregular 'formulario', 'formularios'
	inflect.irregular 'provincia', 'provincias'
	inflect.irregular 'region', 'regiones'
	inflect.irregular 'localidad', 'localidades'
	inflect.irregular 'grupo', 'grupos'
	inflect.irregular 'condicion', 'condiciones'
	inflect.irregular 'registro', 'registros'
	inflect.irregular 'actor', 'actores'
	inflect.irregular 'director', 'directores'
	inflect.irregular 'tecnico', 'tecnicos'
	inflect.irregular 'elenco_en_gira', 'elencos_en_gira'
	inflect.irregular 'integrante_de_elenco_en_gira', 'integrantes_de_elenco_en_gira'
	inflect.irregular 'formato', 'formatos'
	inflect.irregular 'publ_edad', 'publs_edad'
	inflect.irregular 'publ_exp', 'publs_exp'
	inflect.irregular 'responsable', 'responsables'
	inflect.irregular 'gen_esp', 'gen_esps'
	inflect.irregular 'ficha_artistica', 'ficha_artisticas'
	inflect.irregular 'esps_esp', 'esps_esps'
	inflect.irregular 'datos_tec', 'datos_tecs'
	inflect.irregular 'datos_del_responsable', 'datos_del_responsables'
	inflect.irregular 'datos_esp', 'datos_esps'
	inflect.irregular 'datos_grupo', 'datos_grupos'
	inflect.irregular 'persona_juridica', 'personas_juridicas'
	inflect.irregular 'persona_fisica_n', 'personas_fisicas_n'
	inflect.irregular 'persona_fisica_e', 'personas_fisicas_e'
	inflect.irregular 'integrante_comision_directiva', 'integrantes_comision_directiva'
	inflect.irregular 'super_vista', 'super_vistas'
	inflect.irregular 'formulario_terminado', 'formularios_terminados'
	inflect.irregular 'imagen', 'imagenes'
	inflect.irregular 'autorizacion_del_autor', 'autorizaciones_del_autor'
	inflect.irregular 'vista_formulario', 'vista_formularios'
	inflect.irregular 'integrante_rol', 'integrante_roles'
	inflect.irregular 'persona_juridica_e', 'personas_juridicas_e'
	inflect.irregular 'nacionalidad', 'nacionalidades'
	inflect.irregular 'persona_fisica_e_int', 'personas_fisicas_e_int'
	inflect.irregular 'persona_fisica_e_nue', 'personas_fisicas_e_nue'
end