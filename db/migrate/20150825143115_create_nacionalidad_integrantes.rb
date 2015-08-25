class CreateNacionalidadIntegrantes < ActiveRecord::Migration
  def change
    create_table :nacionalidad_integrantes do |t|
      t.string :detalle, :null => false
      t.timestamps null: false
    end
  end
end
