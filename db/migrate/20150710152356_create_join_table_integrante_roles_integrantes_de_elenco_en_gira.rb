class CreateJoinTableIntegranteRolesIntegrantesDeElencoEnGira < ActiveRecord::Migration
  def change
    create_join_table :integrante_roles, :integrantes_de_elenco_en_gira do |t|

    	t.belongs_to :integrante_rol, :null => false
      t.belongs_to :integrante_de_elenco_en_gira, :null => false

      t.index [:integrante_rol_id, :integrante_de_elenco_en_gira_id], name: 'int_rol_int_elenco_gira'
    end
  end
end
