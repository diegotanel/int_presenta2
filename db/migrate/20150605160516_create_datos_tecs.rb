class CreateDatosTecs < ActiveRecord::Migration
  def change
    create_table :datos_tecs do |t|

    	t.string :duracion_montaje, :null => false
    	t.string :duracion_desmontaje, :null => false
    	t.text :descripcion_espacio, :null => false
    	t.string :ancho, :null => false
    	t.string :alto, :null => false
    	t.string :profundidad, :null => false
    	t.text :listado_artefactos_luminicos, :null => false
    	t.text :listado_sonido, :null => false
    	t.text :otros_equipamientos
    	t.string :peso_total, :null => false
    	t.string :volumen_total, :null => false
    	t.text :otras_necesidades
    	t.references :formulario, :null => false

      t.timestamps
    end
    add_index :datos_tecs, :formulario_id
  end
end

