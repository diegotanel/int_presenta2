class CreatePersonasFisicasE < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_e do |t|
    	t.references :integrante_de_elenco_en_gira, index: true, :null => false, foreign_key: true

      t.timestamps null: false
    end
  end
end
