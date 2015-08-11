class IntegranteRol < ActiveRecord::Base

	has_and_belongs_to_many :integrantes_de_elenco_en_gira

	validates :detalle, presence: true

end
