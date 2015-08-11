class CreateJoinTablePublsEdadDatosEsps < ActiveRecord::Migration
  def change
    create_join_table :publs_edad, :datos_esps do |t|

    	t.belongs_to :publ_edad, :null => false
      t.belongs_to :datos_esp, :null => false

      t.index [:publ_edad_id, :datos_esp_id]
    end
  end
end
