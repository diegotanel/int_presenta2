class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.references :formulario, :null => false
      t.references :localidad, :null => false
      t.references :grupo, :null => false
      t.string :nombre, :null => false

      t.timestamps
    end
    add_index :principals, :formulario_id
    add_index :principals, :localidad_id
    add_index :principals, :grupo_id
  end
end
