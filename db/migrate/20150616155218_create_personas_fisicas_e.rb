class CreatePersonasFisicasE < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_e do |t|
    	t.references :integrante_de_elenco_en_gira, index: true, :null => false

      t.timestamps null: false
    end
  end
end
