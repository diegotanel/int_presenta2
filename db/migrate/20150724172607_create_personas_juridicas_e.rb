class CreatePersonasJuridicasE < ActiveRecord::Migration
  def change
    create_table :personas_juridicas_e do |t|
    	t.references :persona_juridica, index: true, :null => false

      t.timestamps null: false
    end
  end
end
