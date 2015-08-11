class CreateFormularios < ActiveRecord::Migration
	def change
    create_table :formularios do |t|
      t.integer :user_id
      t.integer :estado

      t.timestamps
    end
    add_index :formularios, [:user_id, :created_at]
  end
end
