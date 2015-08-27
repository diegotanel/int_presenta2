class CreateExtranjeros < ActiveRecord::Migration
  def change
    create_table :extranjeros do |t|

      t.timestamps null: false
    end
  end
end
