class Nacionalidad < ActiveRecord::Base
	default_scope -> { order('detalle ASC') }

	validates :detalle, presence: true, length: {maximum: 70}
  validates :codigo, presence: true
end
