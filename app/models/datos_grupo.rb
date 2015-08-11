class DatosGrupo < ActiveRecord::Base

	attr_accessor :saltear_validaciones_de_presencia
	belongs_to :formulario

	validates :nombre_grupo, presence: true, unless: :saltear_validaciones_de_presencia
	validates :nombre_grupo, length: {maximum: 70}
	validates :historia, presence: true, unless: :saltear_validaciones_de_presencia
	validates :historia, length: {maximum: 700}
	validates :formulario, presence: true
end
