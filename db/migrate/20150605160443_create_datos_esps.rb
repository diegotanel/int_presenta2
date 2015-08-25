class CreateDatosEsps < ActiveRecord::Migration
  def change
    create_table :datos_esps do |t|
    	t.references :formulario, :null => false, foreign_key: true
    	t.date :fecha_de_estreno
    	t.string :nombre_autor, :null => false
    	t.references :nacionalidad, index: true, :null => false, foreign_key: true
    	t.string :duracion_espectaculo, :null => false
    	t.text :sinopsis_obra, :null => false
    	t.text :pagina_web
    	t.text :facebook
    	t.text :twitter
    	t.text :blog
    	t.text :youtube
    	t.text :instagram


      t.timestamps
    end
    add_index :datos_esps, :formulario_id
  end
end
