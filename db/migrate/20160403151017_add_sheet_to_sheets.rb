class AddSheetToSheets < ActiveRecord::Migration
  def change
    add_column :sheets, :sheet, :string
  end
end
