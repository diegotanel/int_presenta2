class SuperVista < ActiveRecord::Base
	belongs_to :formulario

	validates :formulario, presence: true
end
