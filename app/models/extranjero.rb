class Extranjero < ActiveRecord::Base

	has_one :nacionalidad_integrante, as: :procedencia, dependent: :destroy

	validates :tipo_doc, presence: true, unless: :saltear_validaciones_de_presencia
	validates :tipo_doc, length: {maximum: 30}
	validates :num_doc, presence: true, unless: :saltear_validaciones_de_presencia
  validates :num_doc, numericality: { only_integer: true }, allow_blank: true
end
