class Formulario < ActiveRecord::Base
	belongs_to :user
	has_one :principal, dependent: :destroy
	has_one :elenco_en_gira, dependent: :destroy
	has_one :datos_grupo, dependent: :destroy
	has_one :datos_esp, dependent: :destroy
	has_one :datos_tec, dependent: :destroy
	has_one :responsable, dependent: :destroy
	has_one :super_vista, dependent: :destroy

	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :estado, presence: true

	ESTADOS = {:enviado => 1, :borrador => 2 }
	validates :estado, :presence => true, :inclusion => { :in => self::ESTADOS.values }

	def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
    	csv << column_names
    	csv << formulario.attributes.values_at(*column_names)
  	end
	end

	private
		after_initialize do
			self.estado ||= Formulario::ESTADOS[:borrador]
		end
end
