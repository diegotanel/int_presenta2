class CreatePersonasFisicasENue < ActiveRecord::Migration
  def change
    create_table :personas_fisicas_e_nue do |t|
    	t.references :persona_fisica_n, index: true, :null => false, foreign_key: true

      t.timestamps null: false
    end
  end
end
