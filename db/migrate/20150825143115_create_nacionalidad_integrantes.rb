class CreateNacionalidadIntegrantes < ActiveRecord::Migration
  def change
    create_table :nacionalidad_integrantes do |t|
    	t.integer :procedencia_id
    	t.string :procedencia_type
    	t.references :nacionalidad, index: true, :null => false, foreign_key: true
    	t.references :integrante_de_elenco_en_gira, :null => false, foreign_key: true
      t.timestamps null: false
    end
    add_index :nacionalidad_integrantes, [:procedencia_id, :procedencia_type], name: 'tipo_procedencia'
    add_index :nacionalidad_integrantes, :integrante_de_elenco_en_gira_id, name: 'nacionalidad_integrante_integrante_id'
  end
end
