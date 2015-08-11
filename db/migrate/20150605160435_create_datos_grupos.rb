class CreateDatosGrupos < ActiveRecord::Migration
  def change
    create_table :datos_grupos do |t|
    	t.text :nombre_grupo, :null => false
    	t.text :historia, :null => false
    	t.references :formulario, :null => false

      t.timestamps
    end
    add_index :datos_grupos, :formulario_id
  end
end
