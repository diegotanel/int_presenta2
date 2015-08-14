# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150730191119) do

  create_table "datos_esps", force: :cascade do |t|
    t.integer  "formulario_id",                       null: false
    t.date     "fecha_de_estreno"
    t.string   "nombre_autor",                        null: false
    t.integer  "nacionalidad_id",                     null: false
    t.string   "duracion_espectaculo",                null: false
    t.text     "sinopsis_obra",                       null: false
    t.text     "pagina_web"
    t.text     "facebook"
    t.text     "twitter"
    t.text     "blog"
    t.text     "youtube"
    t.text     "instagram"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "autorizacion_del_autor_file_name"
    t.text     "autorizacion_del_autor_content_type"
    t.integer  "autorizacion_del_autor_file_size"
    t.datetime "autorizacion_del_autor_updated_at"
    t.text     "imagen_file_name"
    t.text     "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  add_index "datos_esps", ["formulario_id"], name: "index_datos_esps_on_formulario_id"
  add_index "datos_esps", ["nacionalidad_id"], name: "index_datos_esps_on_nacionalidad_id"

  create_table "datos_esps_formatos", id: false, force: :cascade do |t|
    t.integer "formato_id",   null: false
    t.integer "datos_esp_id", null: false
  end

  add_index "datos_esps_formatos", ["formato_id", "datos_esp_id"], name: "index_datos_esps_formatos_on_formato_id_and_datos_esp_id"

  create_table "datos_esps_gen_esps", id: false, force: :cascade do |t|
    t.integer "gen_esp_id",   null: false
    t.integer "datos_esp_id", null: false
  end

  add_index "datos_esps_gen_esps", ["gen_esp_id", "datos_esp_id"], name: "index_datos_esps_gen_esps_on_gen_esp_id_and_datos_esp_id"

  create_table "datos_esps_publs_edad", id: false, force: :cascade do |t|
    t.integer "publ_edad_id", null: false
    t.integer "datos_esp_id", null: false
  end

  add_index "datos_esps_publs_edad", ["publ_edad_id", "datos_esp_id"], name: "index_datos_esps_publs_edad_on_publ_edad_id_and_datos_esp_id"

  create_table "datos_esps_publs_exp", id: false, force: :cascade do |t|
    t.integer "publ_exp_id",  null: false
    t.integer "datos_esp_id", null: false
  end

  add_index "datos_esps_publs_exp", ["publ_exp_id", "datos_esp_id"], name: "index_datos_esps_publs_exp_on_publ_exp_id_and_datos_esp_id"

  create_table "datos_grupos", force: :cascade do |t|
    t.text     "nombre_grupo",  null: false
    t.text     "historia",      null: false
    t.integer  "formulario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datos_grupos", ["formulario_id"], name: "index_datos_grupos_on_formulario_id"

  create_table "datos_tecs", force: :cascade do |t|
    t.string   "duracion_montaje",             null: false
    t.string   "duracion_desmontaje",          null: false
    t.text     "descripcion_espacio",          null: false
    t.string   "ancho",                        null: false
    t.string   "alto",                         null: false
    t.string   "profundidad",                  null: false
    t.text     "listado_artefactos_luminicos", null: false
    t.text     "listado_sonido",               null: false
    t.text     "otros_equipamientos"
    t.string   "peso_total",                   null: false
    t.string   "volumen_total",                null: false
    t.text     "otras_necesidades"
    t.integer  "formulario_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "imagen_file_name"
    t.text     "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  add_index "datos_tecs", ["formulario_id"], name: "index_datos_tecs_on_formulario_id"

  create_table "datos_tecs_esps_esps", id: false, force: :cascade do |t|
    t.integer "esps_esp_id",  null: false
    t.integer "datos_tec_id", null: false
  end

  add_index "datos_tecs_esps_esps", ["esps_esp_id", "datos_tec_id"], name: "index_datos_tecs_esps_esps_on_esps_esp_id_and_datos_tec_id"

  create_table "elencos_en_gira", force: :cascade do |t|
    t.integer  "formulario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "elencos_en_gira", ["formulario_id"], name: "index_elencos_en_gira_on_formulario_id"

  create_table "esps_esps", force: :cascade do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ficha_artisticas", force: :cascade do |t|
    t.string   "nombre_artista",   null: false
    t.string   "apellido_artista", null: false
    t.string   "rol_artista",      null: false
    t.integer  "datos_esp_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ficha_artisticas", ["datos_esp_id"], name: "index_ficha_artisticas_on_datos_esp_id"

  create_table "formatos", force: :cascade do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formularios", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formularios", ["user_id", "created_at"], name: "index_formularios_on_user_id_and_created_at"

  create_table "gen_esps", force: :cascade do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grupos", force: :cascade do |t|
    t.string   "detalle",    null: false
    t.string   "codigo",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integrante_roles", force: :cascade do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integrante_roles_integrantes_de_elenco_en_gira", id: false, force: :cascade do |t|
    t.integer "integrante_rol_id",               null: false
    t.integer "integrante_de_elenco_en_gira_id", null: false
  end

  add_index "integrante_roles_integrantes_de_elenco_en_gira", ["integrante_rol_id", "integrante_de_elenco_en_gira_id"], name: "int_rol_int_elenco_gira"

  create_table "integrantes_comision_directiva", force: :cascade do |t|
    t.string   "cargo",               null: false
    t.string   "nombre",              null: false
    t.string   "apellido",            null: false
    t.string   "cuil_cuit",           null: false
    t.date     "fecha_de_nacimiento", null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.integer  "localidad_id",        null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.integer  "persona_juridica_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "integrantes_comision_directiva", ["localidad_id"], name: "index_integrantes_comision_directiva_on_localidad_id"
  add_index "integrantes_comision_directiva", ["persona_juridica_id"], name: "index_integrantes_comision_directiva_on_persona_juridica_id"

  create_table "integrantes_de_elenco_en_gira", force: :cascade do |t|
    t.string   "nombre",              null: false
    t.string   "apellido",            null: false
    t.string   "cuil_cuit",           null: false
    t.date     "fecha_de_nacimiento"
    t.integer  "nacionalidad_id",     null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.integer  "localidad_id",        null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.integer  "elenco_en_gira_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "integrantes_de_elenco_en_gira", ["elenco_en_gira_id"], name: "index_integrantes_de_elenco_en_gira_on_elenco_en_gira_id"
  add_index "integrantes_de_elenco_en_gira", ["localidad_id"], name: "index_integrantes_de_elenco_en_gira_on_localidad_id"
  add_index "integrantes_de_elenco_en_gira", ["nacionalidad_id"], name: "index_integrantes_de_elenco_en_gira_on_nacionalidad_id"

  create_table "localidades", force: :cascade do |t|
    t.string   "codigo",       null: false
    t.string   "detalle",      null: false
    t.integer  "provincia_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "localidades", ["provincia_id"], name: "index_localidades_on_provincia_id"

  create_table "nacionalidades", force: :cascade do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personas_fisicas_e", force: :cascade do |t|
    t.integer  "integrante_de_elenco_en_gira_id", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "personas_fisicas_e", ["integrante_de_elenco_en_gira_id"], name: "index_personas_fisicas_e_on_integrante_de_elenco_en_gira_id"

  create_table "personas_fisicas_e_int", force: :cascade do |t|
    t.integer  "integrante_de_elenco_en_gira_id", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "personas_fisicas_e_int", ["integrante_de_elenco_en_gira_id"], name: "per_fis_e_int_elenco_gira"

  create_table "personas_fisicas_e_nue", force: :cascade do |t|
    t.integer  "persona_fisica_n_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "personas_fisicas_e_nue", ["persona_fisica_n_id"], name: "index_personas_fisicas_e_nue_on_persona_fisica_n_id"

  create_table "personas_fisicas_n", force: :cascade do |t|
    t.string   "nombre",              null: false
    t.string   "apellido",            null: false
    t.string   "cuil_cuit",           null: false
    t.date     "fecha_de_nacimiento", null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.integer  "localidad_id",        null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_particular"
    t.string   "tel_celular"
    t.string   "email",               null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "personas_fisicas_n", ["localidad_id"], name: "index_personas_fisicas_n_on_localidad_id"

  create_table "personas_juridicas", force: :cascade do |t|
    t.string   "nombre_per_juridica", null: false
    t.string   "num_cuit",            null: false
    t.string   "num_per_juridica",    null: false
    t.string   "calle",               null: false
    t.string   "altura_calle",        null: false
    t.string   "piso"
    t.string   "depto"
    t.integer  "localidad_id",        null: false
    t.string   "codigo_postal",       null: false
    t.string   "tel_entidad"
    t.string   "email_entidad",       null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "personas_juridicas", ["localidad_id"], name: "index_personas_juridicas_on_localidad_id"

  create_table "personas_juridicas_e", force: :cascade do |t|
    t.integer  "persona_juridica_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "personas_juridicas_e", ["persona_juridica_id"], name: "index_personas_juridicas_e_on_persona_juridica_id"

  create_table "principals", force: :cascade do |t|
    t.integer  "formulario_id", null: false
    t.integer  "localidad_id",  null: false
    t.integer  "grupo_id",      null: false
    t.string   "nombre",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "principals", ["formulario_id"], name: "index_principals_on_formulario_id"
  add_index "principals", ["grupo_id"], name: "index_principals_on_grupo_id"
  add_index "principals", ["localidad_id"], name: "index_principals_on_localidad_id"

  create_table "provincias", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.string   "detalle",    null: false
    t.integer  "region_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provincias", ["region_id"], name: "index_provincias_on_region_id"

  create_table "publs_edad", force: :cascade do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publs_exp", force: :cascade do |t|
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regiones", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.string   "detalle",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responsables", force: :cascade do |t|
    t.integer  "responsabilidad_id"
    t.string   "responsabilidad_type"
    t.integer  "formulario_id",        null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "responsables", ["responsabilidad_id", "responsabilidad_type"], name: "tipo_responsable"

  create_table "super_vistas", force: :cascade do |t|
    t.integer  "formulario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "super_vistas", ["formulario_id"], name: "index_super_vistas_on_formulario_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "last_name",      null: false
    t.string   "email",          null: false
    t.string   "password",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end