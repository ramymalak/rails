class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.references :group, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
