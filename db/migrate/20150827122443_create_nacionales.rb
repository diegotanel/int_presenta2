class CreateNacionales < ActiveRecord::Migration
  def change
    create_table :nacionales do |t|
    	t.string :cuil_cuit, :null => false

      t.timestamps null: false
    end
  end
end
