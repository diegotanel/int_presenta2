class Localidad < ActiveRecord::Base
	default_scope -> { order('detalle ASC') }

  has_one :principal
	belongs_to :provincia

	validates :detalle, presence: true, length: {maximum: 70}
	validates :provincia, presence: true
  validates :codigo, presence: true
end
