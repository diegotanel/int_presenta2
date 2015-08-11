class CreateGenEsps < ActiveRecord::Migration
  def change
    create_table :gen_esps do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end
