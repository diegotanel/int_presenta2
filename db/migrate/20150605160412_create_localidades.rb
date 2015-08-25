class CreateLocalidades < ActiveRecord::Migration
  def change
    create_table :localidades do |t|
      t.string :codigo, :null => false
      t.string :detalle, :null => false
      t.references :provincia, :null => false, foreign_key: true

      t.timestamps
    end
    add_index :localidades, :provincia_id
  end
end
