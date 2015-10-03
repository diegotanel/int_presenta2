class FichaArtistica < ActiveRecord::Base

	belongs_to :datos_esp

	validates :datos_esp, presence: true
	validates :nombre_artista, presence: true
	validates :apellido_artista, presence: true
	validates :rol_artista, presence: true
	validate :validacion_minimo_un_artista, unless: :saltear_validaciones_de_presencia

	def validacion_minimo_un_artista
    errors[:base] << "Como mínimo se debe adicionar un artísta a la ficha" unless minimo_un_artista
  end

  def minimo_un_artista
    artista = 0
    for x in @formulario.datos_esp.ficha_artisticas
      artista += 1
    end
    artista < 1 ? false : true
  end
end