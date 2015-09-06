class CreateIntegrantesDeElencoEnGira < ActiveRecord::Migration
  def change
    create_table :integrantes_de_elenco_en_gira do |t|
      t.string :nombre
      t.string :apellido
      t.date :fecha_de_nacimiento
      t.string :calle
      t.string :altura_calle
      t.string :piso
      t.string :depto
      t.references :localidad, index: true, foreign_key: true
      t.string :codigo_postal
      t.string :tel_particular
      t.string :prefijo_tel_part
      t.string :prefijo_tel_cel
      t.string :tel_particular
      t.string :tel_celular
      t.string :email
      t.references :elenco_en_gira, index: true, foreign_key: true

      t.timestamps
    end
  end
end
