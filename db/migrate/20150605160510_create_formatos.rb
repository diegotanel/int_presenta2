class CreateFormatos < ActiveRecord::Migration
  def change
    create_table :formatos do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end
