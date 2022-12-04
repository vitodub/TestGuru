class DropTableUsertests < ActiveRecord::Migration[6.1]
  def up
    drop_table :usertests, if_exists: true
  end
end
