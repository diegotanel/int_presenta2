class CreateElencosEnGira < ActiveRecord::Migration
  def change
    create_table :elencos_en_gira do |t|
    	t.references :formulario, :null => false, foreign_key: true

      t.timestamps
    end
    add_index :elencos_en_gira, :formulario_id
  end
end