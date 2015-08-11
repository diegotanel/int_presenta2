class CreateJoinTablePublsExpDatosEsps < ActiveRecord::Migration
  def change
    create_join_table :publs_exp, :datos_esps do |t|

    	t.belongs_to :publ_exp, :null => false
      t.belongs_to :datos_esp, :null => false

			t.index [:publ_exp_id, :datos_esp_id]
    end
  end
end