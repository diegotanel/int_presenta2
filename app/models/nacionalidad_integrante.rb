class NacionalidadIntegrante < ActiveRecord::Base

	belongs_to :integrante_de_elenco_en_gira
	belongs_to :procedencia, polymorphic: true, dependent: :destroy
	belongs_to :nacionalidad

	attr_accessor :saltear_validaciones_de_presencia

	validates_associated :procedencia
	validates_associated :nacionalidad
	
	validates :nacionalidad, presence: true
	validates :procedencia, presence: true
	validates :integrante_de_elenco_en_gira, presence: true

	def tipo_documento
    if procedencia_type == "Nacional"
    	"CUIL / CUIT"
    else
    	procedencia.tipo_doc
    end
  end

  def numero_documento
  	if procedencia_type == "Nacional"
    	procedencia.cuil_cuit
    else
    	procedencia.num_doc
    end
  end


end
