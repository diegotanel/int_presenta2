#encoding: utf-8
class GeneradorDeRemito

  # def obtener_datos_para_remito(formulario)
  #   datos = OpenStruct.new(
  #     fecha_de_impresion_del_remito: I18n.l(Time.zone.now, format: :con_seg),
  #     nombre_del_espectaculo: formulario.principal.nombre,
  #     provincia: formulario.principal.provincia.detalle,
  #     region: formulario.principal.provincia.region.detalle,
  #     numero_de_tramite: formulario.id.to_s,
  #     fecha_de_tramite: I18n.l(formulario.created_at, format: :con_seg),
  #     datos_del_responsable: "fruta"
  #   )
  # end

  def initialize
    @fecha_inicializacion = Time.zone.now.to_formatted_s(:number)
  end

  def generar_pdf(formulario)
    @formulario = formulario
    @datos_del_responsable = nil

    if formulario.responsable
      if formulario.responsable.persona_fisica_e
        @responsable = formulario.responsable.persona_fisica_e if formulario.responsable.persona_fisica_e
        @datos_del_responsable = @responsable.integrante_de_elenco_en_gira.nombre + " " + @responsable.integrante_de_elenco_en_gira.apellido + " - " + "Fecha de nacimiento: " + I18n.l(@responsable.integrante_de_elenco_en_gira.fecha_de_nacimiento, format: :short) + " - " + "CUIT / CUIL: " + @responsable.integrante_de_elenco_en_gira.cuil_cuit
      end

      if formulario.responsable.persona_fisica_n
        @responsable = formulario.responsable.persona_fisica_n
        @datos_del_responsable = @responsable.nombre + " " + @responsable.apellido + " - " + "Fecha de nacimiento: " + I18n.l(@responsable.fecha_de_nacimiento, format: :short) + " - " + "CUIT / CUIL: " + @responsable.cuil_cuit
      end

      if formulario.responsable.persona_juridica
        @responsable = formulario.responsable.persona_juridica
        @datos_del_responsable = @responsable.nombre_per_juridica + " - " + "CUIT: " + @responsable.num_cuit
      end
    end


    report = ODFReport::Report.new(Rails.root.join("app/plantillas/REMITO_INT_PRESENTA_CONFIRMACION.odt")) do |r|
      r.add_field("FECHA_DE_IMPRESION_DEL_REMITO", I18n.l(Time.zone.now, format: :con_seg))
      r.add_field("NOMBRE_DEL_ESPECTACULO", formulario.principal.nombre)
      r.add_field("PROVINCIA", formulario.principal.provincia.detalle)
      r.add_field("REGION", formulario.principal.provincia.region.detalle)
      r.add_field("NUMERO_DE_TRAMITE", formulario.id.to_s)
      r.add_field("FECHA_DE_TRAMITE", I18n.l(formulario.created_at, format: :con_seg))
      r.add_field("DATOS_DEL_RESPONSABLE", @datos_del_responsable)
    end
    @ruta_remito_odt = Rails.root.join("public/remitos/" + nombre_remito_odt)
    report.generate(@ruta_remito_odt)
    @ruta_remitos = Rails.root.join("public/remitos/")
    `libreoffice --headless --invisible --convert-to pdf -outdir #{@ruta_remitos} #{@ruta_remito_odt}`
  end

  def nombre_remito_pdf
    nombre_remito + ".pdf"
  end

  private

  def nombre_remito_odt
    nombre_remito + ".odt"
  end

  def nombre_remito
    "remito_convocatoria_2015_" + @fecha_inicializacion
  end

end
