class CreateJoinTableGenEspsDatosEsps < ActiveRecord::Migration
  def change
    create_join_table :gen_esps, :datos_esps do |t|

    	t.belongs_to :gen_esp, :null => false
      t.belongs_to :datos_esp, :null => false

      t.index [:gen_esp_id, :datos_esp_id]
    end
  end
end

