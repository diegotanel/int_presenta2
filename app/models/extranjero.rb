class Extranjero < ActiveRecord::Base

	attr_accessor :saltear_validaciones_de_presencia
	has_one :nacionalidad_integrante, as: :procedencia, dependent: :destroy
	#validates :tipo_doc, presence: true, unless: :saltear_validaciones_de_presencia
	validates :tipo_doc, length: {maximum: 30}, presence: true  	
	#validates :num_doc, presence: true, unless: :saltear_validaciones_de_presencia
  validates :num_doc, length: {maximum: 30}, presence: true  	
end
