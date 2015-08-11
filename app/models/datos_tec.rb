class DatosTec < ActiveRecord::Base

  attr_accessor :saltear_validaciones_de_presencia
  belongs_to :formulario
  has_and_belongs_to_many :esps_esps, class_name: 'EspsEsp'

  validates :formulario, presence: true
  validates :esps_esps, presence: true, unless: :saltear_validaciones_de_presencia
  validates :duracion_montaje, presence: :true, unless: :saltear_validaciones_de_presencia
  validates :duracion_montaje, numericality: { only_integer: true }, allow_blank: true
  validates :duracion_desmontaje, presence: true, unless: :saltear_validaciones_de_presencia
  validates :duracion_desmontaje, numericality: { only_integer: true }, allow_blank: true
  validates :ancho, presence: true, unless: :saltear_validaciones_de_presencia
  validates :ancho, numericality: true, allow_blank: true
  validates :alto, presence: true, unless: :saltear_validaciones_de_presencia
  validates :alto, numericality: true, allow_blank: true
  validates :profundidad, presence: true, unless: :saltear_validaciones_de_presencia
  validates :profundidad, numericality: true, allow_blank: true
  validates :listado_artefactos_luminicos, presence: true, unless: :saltear_validaciones_de_presencia
  validates :listado_artefactos_luminicos, length: {maximum: 500}
  validates :listado_sonido, presence: true, unless: :saltear_validaciones_de_presencia
  validates :listado_sonido, length: {maximum: 500}
  validates :otros_equipamientos, length: {maximum: 500}
  validates :peso_total, presence: true, unless: :saltear_validaciones_de_presencia
  validates :peso_total, numericality: { only_integer: true }, allow_blank: true
  validates :volumen_total, presence: true, unless: :saltear_validaciones_de_presencia
  validates :volumen_total, numericality: { only_integer: true }, allow_blank: true
  validates :otras_necesidades, length: {maximum: 500}
  validates :descripcion_espacio, presence: true, unless: :saltear_validaciones_de_presencia
  validates :descripcion_espacio, length: {maximum: 500}

  has_attached_file :imagen, styles: { medium: '300x300>', thumb: '48x48>' }
  validates_attachment :imagen, :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", 'application/pdf'] },
    :size => { :less_than => 1.megabyte }

  def ancho=(val)
    val.sub!(',', '.') if val.is_a?(String)
    self['ancho'] = val
  end

  def alto=(val)
    val.sub!(',', '.') if val.is_a?(String)
    self['alto'] = val
  end

  def profundidad=(val)
    val.sub!(',', '.') if val.is_a?(String)
    self['profundidad'] = val
  end
end
