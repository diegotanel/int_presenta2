#encoding: utf-8
class DatosEsp < ActiveRecord::Base

	attr_accessor :saltear_validaciones_de_presencia
	belongs_to :formulario
	has_many :integrantes_del_esp
	has_many :ficha_artisticas
	has_and_belongs_to_many :gen_esps, class_name: 'GenEsp'
	has_and_belongs_to_many :publs_exp, class_name: 'PublExp'
	has_and_belongs_to_many :publs_edad, class_name: 'PublEdad'
	has_and_belongs_to_many :formatos, class_name: 'Formato'
	belongs_to :nacionalidad

	validate :validacion_fecha_de_estreno_debe_ser_inferior_al_dia_actual

	validates :formulario, presence: true, unless: :saltear_validaciones_de_presencia
	validates :fecha_de_estreno, presence: true, unless: :saltear_validaciones_de_presencia
	validates :nombre_autor, presence: true, unless: :saltear_validaciones_de_presencia
	validates :nombre_autor, length: {maximum: 100}
	validates :duracion_espectaculo, presence: true, unless: :saltear_validaciones_de_presencia
	validates :duracion_espectaculo, numericality: { only_integer: true }, allow_blank: true
	validates :sinopsis_obra, presence: true, unless: :saltear_validaciones_de_presencia
	validates :sinopsis_obra, length: {maximum: 700}
	validates :nacionalidad, presence: true
	validates :gen_esps, presence: true, unless: :saltear_validaciones_de_presencia
	validates :publs_edad, presence: true, unless: :saltear_validaciones_de_presencia
	validates :publs_exp, presence: true, unless: :saltear_validaciones_de_presencia
	validates :formatos, presence: true, unless: :saltear_validaciones_de_presencia
	validates :pagina_web, length: {maximum: 700}
	validates :facebook, length: {maximum: 700}
	validates :twitter, length: {maximum: 700}
	validates :blog, length: {maximum: 700}
	validates :youtube, length: {maximum: 700}
	validates :instagram, length: {maximum: 700}
	validate :validacion_minimo_un_artista, unless: :saltear_validaciones_de_presencia

	has_attached_file :imagen, styles: { medium: '300x300>', thumb: '48x48>' }
	validates_attachment :imagen, :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", 'application/pdf'] },
                                :size => { :less_than => 1.megabyte }
  validates_attachment :imagen, presence: true, unless: :saltear_validaciones_de_presencia

  has_attached_file :autorizacion_del_autor, styles: { medium: '300x300>', thumb: '48x48>' }
  validates_attachment :autorizacion_del_autor, :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", 'application/pdf'] },
                                :size => { :less_than => 1.megabyte }
  validates_attachment :autorizacion_del_autor, presence: true, unless: :saltear_validaciones_de_presencia

	#ransacker :duracion_espectaculo, formatter: proc { |v| v.to_i } do |parent|
  #	parent.table[:duracion_espectaculo]

	#, validator: proc { |v| v.present? } do |p|
	#	puts p.class
	#formatter: proc { |v| v.to_i },

  
  		#Arel.sql("to_number(duracion_espectaculo, '99999')")
	#end

	def validacion_fecha_de_estreno_debe_ser_inferior_al_dia_actual
		errors[:fecha_de_estreno] << "no puede ser superior al día actual" unless fecha_de_estreno_debe_ser_inferior_al_dia_actual
	end

	def fecha_de_estreno_debe_ser_inferior_al_dia_actual
		if fecha_de_estreno.presence
			fecha_de_estreno <= Date.today
		end
	end

	def validacion_minimo_un_artista
    errors[:base] << "Como mínimo se debe adicionar un artísta a la ficha" unless minimo_un_artista
  end

  def minimo_un_artista
    artista = 0
    for x in self.ficha_artisticas
      artista += 1
    end
    artista < 1 ? false : true
  end

end
