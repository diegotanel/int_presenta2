class CreateJoinTableEspsEspsDatosTecs < ActiveRecord::Migration
  def change
    create_join_table :esps_esps, :datos_tecs do |t|

    	t.belongs_to :esps_esp, :null => false
      t.belongs_to :datos_tec, :null => false

      t.index [:esps_esp_id, :datos_tec_id]
    end
  end
end