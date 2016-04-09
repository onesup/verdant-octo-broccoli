class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.datetime :started_at
      t.datetime :finished_at
      t.string :name
      t.string :type
      t.references :holidayable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
