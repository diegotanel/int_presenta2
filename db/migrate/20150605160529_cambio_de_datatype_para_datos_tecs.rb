class CambioDeDatatypeParaDatosTecs < ActiveRecord::Migration
  def up
    change_table :datos_tecs do |t|
      t.change :imagen_file_name, :text
      t.change :imagen_content_type, :text
    end
  end

  def down
    change_table :datos_tecs do |t|
      t.change :imagen_file_name, :string
      t.change :imagen_content_type, :string
    end
  end
end
