class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.integer :age
      t.boolean :gender
      t.references :country, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.boolean :isAdmin
      t.boolean :isConf

      t.timestamps null: false
    end
  end
end
