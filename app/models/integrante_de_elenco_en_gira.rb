#encoding: utf-8
class IntegranteDeElencoEnGira < ActiveRecord::Base

  has_and_belongs_to_many :integrante_roles, class_name: 'IntegranteRol'
  unless :saltear_validaciones_de_telefono
    before_save :validacion_tel_particular_tel_celular!
  end

  unless :saltear_validaciones_de_cuil
    before_save :validacion_digitoverificador_de_cuit_cuil!
  end
  
  attr_accessor :saltear_validaciones_de_presencia
  attr_accessor :saltear_validaciones_de_telefono
  attr_accessor :saltear_validaciones_de_email
  attr_accessor :saltear_validaciones_de_cuil


  belongs_to :localidad
  belongs_to :elenco_en_gira
  has_one :nacionalidad_integrante

  unless :saltear_validaciones_de_email
    before_save { self.email = email.downcase }
  end
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

  validates :nombre, presence: true, unless: :saltear_validaciones_de_presencia
  validates :nombre, length: {maximum: 70}
  validates :apellido, presence: true, unless: :saltear_validaciones_de_presencia
  validates :apellido, length: {maximum: 70}
  validates :cuil_cuit, presence: true, unless: :saltear_validaciones_de_presencia
  validates :cuil_cuit, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }, unless: :saltear_validaciones_de_cuil
  validates :fecha_de_nacimiento, presence: true, unless: :saltear_validaciones_de_presencia
  validates :calle, presence: true, unless: :saltear_validaciones_de_presencia
  validates :altura_calle, presence: true, unless: :saltear_validaciones_de_presencia
  validates :altura_calle, numericality: { only_integer: true }, allow_blank: true
  validates :localidad, presence: true, allow_blank: true
  validates :codigo_postal, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email, format: {with: VALID_EMAIL_REGEX}, unless: :saltear_validaciones_de_email
  validates :nacionalidad_integrante, presence: true, allow_blank: true
  validates :elenco_en_gira, presence: true
  validates :integrante_roles, presence: true, unless: :saltear_validaciones_de_presencia
  validates :tel_particular, numericality: { only_integer: true }, allow_blank: true
  #validates :tel_celular, presence: true, unless: :saltear_validaciones_de_presencia
  validates :tel_celular, numericality: { only_integer: true }, allow_blank: true

  def es_menor?
    18.years.ago < self.fecha_de_nacimiento
  end

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

  def validacion_tel_particular_tel_celular!
    @es_valido = nil
    tel_particular.blank? ? @es_valido = false : @es_valido = true

    unless @es_valido
      if tel_celular.blank?
        errors[:base] << "Debe completarse el teléfono particular o el teléfono celular"
        return false
      end
    end
  end
end