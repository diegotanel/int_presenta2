class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.references :formulario, :null => false, foreign_key: true
      t.references :localidad, :null => false, foreign_key: true
      t.references :grupo, :null => false, foreign_key: true
      t.string :nombre, :null => false
      t.string :nombre_contacto, :null => false
      t.string :apellido_contacto, :null => false
      t.string :prefijo_tel_part, :null => false
      t.string :prefijo_tel_cel, :null => false
      t.string :tel_particular, :null => false
      t.string :tel_celular, :null => false
      t.string :email_contacto, :null => false

      t.timestamps
    end
    add_index :principals, :formulario_id
    add_index :principals, :localidad_id
    add_index :principals, :grupo_id
  end
end
