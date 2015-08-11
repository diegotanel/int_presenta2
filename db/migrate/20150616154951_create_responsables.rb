class CreateResponsables < ActiveRecord::Migration
  def change
    create_table :responsables do |t|
    	t.integer :responsabilidad_id
    	t.string :responsabilidad_type
    	t.references :formulario, :null => false

      t.timestamps null: false
    end
    add_index :responsables, [:responsabilidad_id, :responsabilidad_type], name: 'tipo_responsable'
  end
end
