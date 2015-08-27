class NacionalidadIntegrante < ActiveRecord::Base

	belongs_to :integrante_de_elenco_en_gira
	belongs_to :nacionalidad
end
