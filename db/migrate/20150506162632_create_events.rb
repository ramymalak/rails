class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :place
      t.references :group, index: true, foreign_key: true
      t.text :description
      t.datetime :date

      t.timestamps null: false
    end
  end
end
