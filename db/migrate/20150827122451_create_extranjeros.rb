class CreateExtranjeros < ActiveRecord::Migration
  def change
    create_table :extranjeros do |t|
    	t.string :tipo_doc, :null => false
    	t.string :num_doc, :null => false

      t.timestamps null: false
    end
  end
end
