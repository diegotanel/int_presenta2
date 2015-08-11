class AddAttachmentImagenToDatosEsps < ActiveRecord::Migration
  def self.up
    change_table :datos_esps do |t|
      t.attachment :imagen
    end
  end

  def self.down
    remove_attachment :datos_esps, :imagen
  end
end
