class Provincia < ActiveRecord::Base
	default_scope -> { order('detalle ASC') }

  has_one :principal
	belongs_to :region
	has_many :localidades

	validates :detalle, presence: true, length: {maximum: 70}
	validates :region, presence: true
  validates :codigo, presence: true
end
