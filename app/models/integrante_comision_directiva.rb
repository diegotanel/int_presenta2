#encoding: utf-8
class IntegranteComisionDirectiva < ActiveRecord::Base

  before_save :validacion_tel_particular_tel_celular!
  before_save :validacion_digitoverificador_de_cuit_cuil!

  attr_accessor :saltear_validaciones_de_presencia
  belongs_to :localidad

  belongs_to :persona_juridica

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad

  validates :nombre, presence: true, unless: :saltear_validaciones_de_presencia
  validates :nombre, length: {maximum: 70}
  validates :apellido, presence: true, unless: :saltear_validaciones_de_presencia
  validates :apellido, length: {maximum: 70}
  validates :cargo, presence: true, unless: :saltear_validaciones_de_presencia
  validates :cuil_cuit, presence: true, unless: :saltear_validaciones_de_presencia
  validates :cuil_cuit, length: {maximum: 11, minimum: 11}, numericality: { only_integer: true }, uniqueness: { case_sensitive: false }
  validates :fecha_de_nacimiento, presence: true
  validates :calle, presence: true, unless: :saltear_validaciones_de_presencia
  validates :altura_calle, presence: true, unless: :saltear_validaciones_de_presencia
  validates :altura_calle, numericality: { only_integer: true }, allow_blank: true
  validates :localidad, presence: true
  validates :codigo_postal, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :persona_juridica, presence: true
  validates :tel_particular, numericality: { only_integer: true }, allow_blank: true
  validates :tel_celular, numericality: { only_integer: true }, allow_blank: true
  validates :prefijo_tel_part, numericality: { only_integer: true }, length: {maximum: 6}, allow_blank: true
  validates :prefijo_tel_cel, numericality: { only_integer: true }, length: {maximum: 6}, allow_blank: true

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

