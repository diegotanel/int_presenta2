class CambioDeDatatypeParaDatosEsps < ActiveRecord::Migration
  def up
    change_table :datos_esps do |t|
      t.change :autorizacion_del_autor_file_name, :text
      t.change :autorizacion_del_autor_content_type, :text
      t.change :imagen_file_name, :text
      t.change :imagen_content_type, :text
    end
  end

  def down
    change_table :datos_esps do |t|
      t.change :autorizacion_del_autor_file_name, :string
      t.change :autorizacion_del_autor_content_type, :string
      t.change :imagen_file_name, :string
      t.change :imagen_content_type, :string
    end
  end
end
