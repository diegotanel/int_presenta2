class CreateIntegrantesDeElencoEnGira < ActiveRecord::Migration
  def change
    create_table :integrantes_de_elenco_en_gira do |t|
      t.string :nombre, :null => false
      t.string :apellido, :null => false
      t.string :cuil_cuit, :null => false
      t.date :fecha_de_nacimiento
      t.references :nacionalidad_integrante, :null => false, foreign_key: true
      t.string :calle, :null => false
      t.string :altura_calle, :null => false
      t.string :piso
      t.string :depto
      t.references :localidad, index: true, :null => false, foreign_key: true
      t.string :codigo_postal, :null => false
      t.string :tel_particular
      t.string :prefijo_tel_part
      t.string :prefijo_tel_cel
      t.string :tel_particular
      t.string :tel_celular
      t.string :email, :null => false
      t.references :elenco_en_gira, index: true, :null => false, foreign_key: true

      t.timestamps
    end
    add_index :integrantes_de_elenco_en_gira, :nacionalidad_integrante_id, name: 'integrante_nacionalidad_integrante_id'
  end
end
