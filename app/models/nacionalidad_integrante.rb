class NacionalidadIntegrante < ActiveRecord::Base

	belongs_to :integrante_de_elenco_en_gira
	belongs_to :procedencia, polymorphic: true, dependent: :destroy
	belongs_to :nacionalidad

	attr_accessor :saltear_validaciones_de_presencia

	validates_associated :procedencia
	validates_associated :nacionalidad
	
	validates :nacionalidad, presence: true
	validates :procedencia, presence: true
	validates :integrante_de_elenco_en_gira, presence: true
end
