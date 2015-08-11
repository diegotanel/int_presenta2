class Responsable < ActiveRecord::Base

	belongs_to :formulario
  belongs_to :responsabilidad, polymorphic: true, dependent: :destroy
end
