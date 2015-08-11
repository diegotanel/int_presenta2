class CreatePublsEdad < ActiveRecord::Migration
  def change
    create_table :publs_edad do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end
