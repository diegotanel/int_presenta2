class CreateRegiones < ActiveRecord::Migration
  def change
    create_table :regiones do |t|
      t.string :codigo, :null => false
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end

