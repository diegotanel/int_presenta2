class GenEsp < ActiveRecord::Base

	has_and_belongs_to_many :datos_esps

	validates :detalle, presence: true
end
