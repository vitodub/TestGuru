class CreateUsertests < ActiveRecord::Migration[6.1]
  def change
    create_table :usertests do |t|
      t.integer :status, null: false
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :test, foreign_key: true, null: false

      t.timestamps
    end
  end
end
