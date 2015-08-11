class CreatePersonasFisicasEInt < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_e_int do |t|
    	t.references :integrante_de_elenco_en_gira, :null => false

      t.timestamps null: false
    end
    add_index :personas_fisicas_e_int, :integrante_de_elenco_en_gira_id, name: 'per_fis_e_int_elenco_gira'
  end
end
