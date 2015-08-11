class PersonaFisicaENue < ActiveRecord::Base
	has_one :responsable, as: :responsabilidad, dependent: :destroy
	belongs_to :persona_fisica_n
	validates :persona_fisica_n, presence: true
end
