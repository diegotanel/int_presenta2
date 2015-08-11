class AddAttachmentImagenToDatosTecs < ActiveRecord::Migration
  def self.up
    change_table :datos_tecs do |t|
      t.attachment :imagen
    end
  end

  def self.down
    remove_attachment :datos_tecs, :imagen
  end
end
