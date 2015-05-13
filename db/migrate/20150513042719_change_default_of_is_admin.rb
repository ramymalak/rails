class ChangeDefaultOfIsAdmin < ActiveRecord::Migration
  def change
    change_column_default :users, :isAdmin, false
    change_column_default :users, :isConf, false
  end
end
