class PersonaJuridicaE < ActiveRecord::Base

	has_one :responsable, as: :responsabilidad, dependent: :destroy
	belongs_to :persona_juridica
	validates :persona_juridica, presence: true
end
