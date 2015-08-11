class Region < ActiveRecord::Base
	has_many :provincias

  validates :codigo, presence: true
	validates :detalle, presence: true, length: {maximum: 70}
end
