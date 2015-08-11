class Condicion < ActiveRecord::Base

  has_and_belongs_to_many :principals

  validates :codigo, presence: true
	validates :detalle, presence: true
end
