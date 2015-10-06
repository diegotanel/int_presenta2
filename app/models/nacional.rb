class Nacional < ActiveRecord::Base

	has_one :nacionalidad_integrante, as: :procedencia, dependent: :destroy
  #validates :cuil_cuit, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }, presence: true
  validate :validacion_digitoverificador_de_cuit_cuil!


  def validacion_digitoverificador_de_cuit_cuil!
    @validador = ValidadorCuitCuil.new
    if cuil_cuit.presence
      if cuil_cuit.length == 11
        unless @validador.validardigitoverificador(cuil_cuit)
          errors[:cuil_cuit] << "debe estar formado correctamente"
          return false
        else
          true
        end
      else
        errors[:cuil_cuit] << "El número de cuit debe tener 11 caracteres"
        return false
      end
    end
  end
end
