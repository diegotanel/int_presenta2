class PersonaFisicaE < ActiveRecord::Base

	has_one :responsable, as: :responsabilidad, dependent: :destroy
	validates :integrante_de_elenco_en_gira, presence: true
end
