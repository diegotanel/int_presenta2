class CreatePublsExp < ActiveRecord::Migration
  def change
    create_table :publs_exp do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end
