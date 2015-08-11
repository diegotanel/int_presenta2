class CreateIntegranteRoles < ActiveRecord::Migration
  def change
    create_table :integrante_roles do |t|
    	t.string :detalle, :null => false

      t.timestamps
    end
  end
end
