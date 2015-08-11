class AddAttachmentAutorizacionDelAutorToDatosEsps < ActiveRecord::Migration
  def self.up
    change_table :datos_esps do |t|
      t.attachment :autorizacion_del_autor
    end
  end

  def self.down
    remove_attachment :datos_esps, :autorizacion_del_autor
  end
end
