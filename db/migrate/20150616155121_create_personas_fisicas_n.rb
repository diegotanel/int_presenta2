class CreatePersonasFisicasN < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_n do |t|

    	t.string :nombre, :null => false
      t.string :apellido, :null => false
      t.string :cuil_cuit, :null => false, unique: true
      t.date :fecha_de_nacimiento, :null => false
      t.string :calle, :null => false
      t.string :altura_calle, :null => false
      t.string :piso
      t.string :depto
      t.references :localidad, index: true, :null => false
      t.string :codigo_postal, :null => false
      t.string :tel_particular
      t.string :prefijo_tel_part
      t.string :prefijo_tel_cel
      t.string :tel_celular
      t.string :email, :null => false, unique: true

      t.timestamps null: false
    end
  end
end
