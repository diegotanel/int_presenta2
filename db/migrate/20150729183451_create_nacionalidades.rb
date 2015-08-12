class CreateNacionalidades < ActiveRecord::Migration
  def change
    create_table :nacionalidades do |t|

      t.string :detalle, :null => false
      t.timestamps null: false
    end
  end
end
