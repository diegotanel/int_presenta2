class CreatePersonasJuridicasE < ActiveRecord::Migration
  def change
    create_table :personas_juridicas_e do |t|
    	t.references :persona_juridica, index: true, :null => false, foreign_key: true

      t.timestamps null: false
    end
  end
end
