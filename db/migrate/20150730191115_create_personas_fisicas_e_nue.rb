class CreatePersonasFisicasENue < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_e_nue do |t|
    	t.references :persona_fisica_n, index: true, :null => false

      t.timestamps null: false
    end
  end
end
