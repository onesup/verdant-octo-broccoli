class Sheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.references :user
      t.timestamps null: false
    end
  end
end
