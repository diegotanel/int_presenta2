class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :detalle, :null => false
      t.string :codigo, :null => false

      t.timestamps
    end
  end
end
