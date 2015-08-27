class Extranjero < ActiveRecord::Base

	has_one :nacionalidad_integrante, as: :procedencia, dependent: :destroy
end
