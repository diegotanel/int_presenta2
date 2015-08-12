class Nacionalidad < ActiveRecord::Base
	default_scope -> { order('detalle ASC') }

	#has_many :integrantes_de_elenco_en_gira

	validates :detalle, presence: true, length: {maximum: 70}
end
