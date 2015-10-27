class PersonaJuridica < ActiveRecord::Base

	has_one :responsable, as: :responsabilidad, dependent: :destroy
	attr_accessor :saltear_validaciones_de_presencia

  before_save :validacion_digitoverificador_de_cuit_cuil!

  belongs_to :localidad
  has_many :integrantes_comision_directiva

  before_save { self.email_entidad = email_entidad.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

  validates :nombre_per_juridica, presence: true, unless: :saltear_validaciones_de_presencia
  validates :nombre_per_juridica, length: {maximum: 100}
  validates :num_cuit, presence: true, unless: :saltear_validaciones_de_presencia
  validates :num_cuit, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }
  validates :num_per_juridica, presence: true, unless: :saltear_validaciones_de_presencia
  validates :num_per_juridica, numericality: { only_integer: true }
  validates :calle, presence: true, unless: :saltear_validaciones_de_presencia
  validates :altura_calle, presence: true, unless: :saltear_validaciones_de_presencia
  validates :altura_calle, numericality: { only_integer: true }
  validates :localidad, presence: true
  validates :codigo_postal, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email_entidad, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email_entidad, format: {with: VALID_EMAIL_REGEX}
  validates :tel_entidad, presence: true, numericality: { only_integer: true }, unless: :saltear_validaciones_de_presencia


  def validacion_digitoverificador_de_cuit_cuil!
    @validador = ValidadorCuitCuil.new
    if num_cuit.presence
      unless @validador.validardigitoverificador(self.num_cuit)
        errors[:num_cuit] << "debe estar formado correctamente"
        return false
      else
        true
      end
    end
  end
end
