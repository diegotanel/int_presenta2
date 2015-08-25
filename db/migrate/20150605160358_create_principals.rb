class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.references :formulario, :null => false, foreign_key: true
      t.references :localidad, :null => false, foreign_key: true
      t.references :grupo, :null => false, foreign_key: true
      t.string :nombre, :null => false

      t.timestamps
    end
    add_index :principals, :formulario_id
    add_index :principals, :localidad_id
    add_index :principals, :grupo_id
  end
end
