class CreateIntegrantesComisionDirectiva < ActiveRecord::Migration
  def change
    create_table :integrantes_comision_directiva do |t|
    	t.string :cargo, :null => false
    	t.string :nombre, :null => false
      t.string :apellido, :null => false
      t.string :cuil_cuit, :null => false, unique: true
      t.date :fecha_de_nacimiento, :null => false
      t.string :calle, :null => false
      t.string :altura_calle, :null => false
      t.string :piso
      t.string :depto
      t.references :localidad, index: true, :null => false, foreign_key: true
      t.string :codigo_postal, :null => false
      t.string :tel_particular
      t.string :prefijo_tel_part
      t.string :prefijo_tel_cel
      t.string :tel_celular
      t.string :email, :null => false, unique: true
      t.references :persona_juridica, index: true, :null => false, foreign_key: true

      t.timestamps null: false
    end
  end
end
