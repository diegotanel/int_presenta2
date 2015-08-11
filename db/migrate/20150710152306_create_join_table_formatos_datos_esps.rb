class CreateJoinTableFormatosDatosEsps < ActiveRecord::Migration
  def change
    create_join_table :formatos, :datos_esps do |t|

    	t.belongs_to :formato, :null => false
      t.belongs_to :datos_esp, :null => false

      t.index [:formato_id, :datos_esp_id]
    end
  end
end
