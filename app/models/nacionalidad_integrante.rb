class NacionalidadIntegrante < ActiveRecord::Base
		validates :detalle, presence: true, length: {maximum: 70}
end
