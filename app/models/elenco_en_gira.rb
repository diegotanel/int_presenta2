#encoding: utf-8
class ElencoEnGira < ActiveRecord::Base

  attr_accessor :saltear_validaciones_de_presencia
  attr_accessor :cantidad_integrantes_en_gira
  belongs_to :formulario
  has_many :integrantes_de_elenco_en_gira, dependent: :destroy

  validates :formulario, presence: true
  validates_associated :integrantes_de_elenco_en_gira
  validate :validacion_minimo_un_interprete, unless: :saltear_validaciones_de_presencia 
  validate :validacion_maximo_tres_directores, :validacion_maximo_dos_tecnicos, :validacion_combinacion_director_tecnico
  # # scope :integrantes_gteq, ->(amount) { where('cantidad_integrantes_en_gira >= ?', amount) }
  # # scope :integrantes_lteq, ->(amount) { where('cantidad_integrantes_en_gira <= ?', amount) }
  

  def validacion_minimo_un_interprete
    errors[:base] << "Como mínimo se debe adicionar un intérprete en elenco en gira" unless minimo_un_interprete
  end

  def cantidad_integrantes_en_gira
    self.integrantes_de_elenco_en_gira.count
  end

  def minimo_un_interprete
    actores = 0
    for x in self.integrantes_de_elenco_en_gira
      if x.integrante_roles.ids.include?(1)
        actores += 1
      end
    end
    actores < 1 ? false : true
  end

  def validacion_maximo_tres_directores
    errors[:base] << "No puede haber más de tres directores" unless self.maximo_tres_directores
  end

  def maximo_tres_directores
    directores = 0
    for x in self.integrantes_de_elenco_en_gira
      if x.integrante_roles.ids.include?(2)
        directores += 1
      end
    end
    directores > 2 ? false : true
  end

  def validacion_maximo_dos_tecnicos
    errors[:base] << "No puede haber más de dos técnicos" unless self.maximo_dos_tecnicos
  end

  def maximo_dos_tecnicos
    tecnicos = 0
    for x in self.integrantes_de_elenco_en_gira
      if x.integrante_roles.ids.include?(3)
        tecnicos += 1
      end
    end
    tecnicos > 1 ? false : true
  end

  def validacion_combinacion_director_tecnico
    errors[:base] << "Como máximo la cantidad de tres, entre directores y técnicos" unless self.combinacion_director_tecnico
  end

  def combinacion_director_tecnico
    tecnicos = 0
    directores = 0
    for x in self.integrantes_de_elenco_en_gira
      if x.integrante_roles.ids.include?(3)
        tecnicos += 1
      end
      if x.integrante_roles.ids.include?(2)
        directores += 1
      end
    end
    directores + tecnicos > 2 ? false : true
  end

  # private
  #   def self.ransackable_scopes(auth_object = nil)
  #     [:integrantes_lteq, :integrantes_gteq]
  #   end
end