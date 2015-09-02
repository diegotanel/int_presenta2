class Nacional < ActiveRecord::Base

	has_one :nacionalidad_integrante, as: :procedencia, dependent: :destroy

	attr_accessor :saltear_validaciones_de_cuil

	unless :saltear_validaciones_de_cuil
    before_save :validacion_digitoverificador_de_cuit_cuil!
  end

	validates :cuil_cuit, presence: true, unless: :saltear_validaciones_de_presencia
  validates :cuil_cuit, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }, unless: :saltear_validaciones_de_cuil


  def validacion_digitoverificador_de_cuit_cuil!
    @validador = ValidadorCuitCuil.new
    if cuil_cuit.presence
      unless @validador.validardigitoverificador(self.cuil_cuit)
        errors[:cuil_cuit] << "debe estar formado correctamente"
        return false
      else
        true
      end
    end
  end
end
