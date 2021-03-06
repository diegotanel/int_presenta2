class Principal < ActiveRecord::Base
  belongs_to :grupo
  belongs_to :localidad
  belongs_to :formulario

  attr_accessor :saltear_validaciones_de_presencia
  attr_accessor :saltear_validaciones_de_email

  unless :saltear_validaciones_de_email
    before_save { self.email = email.downcase }
  end

  before_save :validacion_tel_particular_tel_celular!
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i


  delegate :provincia, to: :localidad
  delegate :provincia_id, to: :localidad
  delegate :region, to: 'localidad.provincia'
  delegate :region_id, to: 'localidad.provincia'

  validates :grupo, presence: true
  validates :localidad, presence: true
  validates :nombre, presence: true, length: {maximum: 70}
  validates :formulario, presence: true
  validates :nombre_contacto, presence: true, length: {maximum: 70}, unless: :saltear_validaciones_de_presencia
  validates :apellido_contacto, presence: true, length: {maximum: 70}, unless: :saltear_validaciones_de_presencia
  validates :prefijo_tel_part, numericality: { only_integer: true }, length: {maximum: 6}, allow_blank: true
  validates :tel_particular, numericality: { only_integer: true }, allow_blank: true
  validates :prefijo_tel_cel, numericality: { only_integer: true }, length: {maximum: 6}, allow_blank: true
  validates :tel_celular, numericality: { only_integer: true }, allow_blank: true
  validates :email_contacto, presence: true, unless: :saltear_validaciones_de_presencia
  validates :email_contacto, format: {with: VALID_EMAIL_REGEX}, unless: :saltear_validaciones_de_email

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