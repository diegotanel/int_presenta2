class CreatePersonasJuridicas < ActiveRecord::Migration
  def change
    create_table :personas_juridicas do |t|

    	t.string :nombre_per_juridica, :null => false
    	t.string :num_cuit, :null => false, unique: true
    	t.string :num_per_juridica, :null => false
      t.string :calle, :null => false
      t.string :altura_calle, :null => false
      t.string :piso
      t.string :depto
      t.references :localidad, index: true, :null => false, foreign_key: true
      t.string :codigo_postal, :null => false
      t.string :tel_entidad
      t.string :prefijo_tel_ent
      t.string :email_entidad, :null => false, unique: true

      t.timestamps null: false
    end
  end
end
