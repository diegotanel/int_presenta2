class NacionalidadIntegrante < ActiveRecord::Base

	belongs_to :integrante_de_elenco_en_gira
	belongs_to :procedencia, polymorphic: true, dependent: :destroy
	belongs_to :nacionalidad
	# accepts_nested_attributes_for :nacionalidad
	# accepts_nested_attributes_for :procedencia

	attr_accessor :saltear_validaciones_de_presencia

	validates :nacionalidad, presence: true, unless: :saltear_validaciones_de_presencia
	validates :integrante_de_elenco_en_gira, presence: true
end
