class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :mother, index: true
      t.string :nation
      t.timestamps null: false
    end
  end
end
