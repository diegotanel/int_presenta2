class PersonaFisicaEInt < ActiveRecord::Base
	has_one :responsable, as: :responsabilidad, dependent: :destroy
	belongs_to :integrante_de_elenco_en_gira
	validates :integrante_de_elenco_en_gira, presence: true
  validates_associated :integrante_de_elenco_en_gira
end
