class CreateNacionales < ActiveRecord::Migration
  def change
    create_table :nacionales do |t|

      t.timestamps null: false
    end
  end
end
