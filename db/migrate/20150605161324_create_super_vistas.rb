class CreateSuperVistas < ActiveRecord::Migration
  def change
    create_table :super_vistas do |t|
    	t.references :formulario, :null => false

      t.timestamps
    end
    add_index :super_vistas, :formulario_id
  end
end
