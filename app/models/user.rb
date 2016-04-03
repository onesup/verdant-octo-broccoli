class User < ActiveRecord::Base
  def self.build_users_from_sheet(file)
    sheet_file = Roo::Spreadsheet.open(file)
    sheet_file.default_sheet = sheet_file.sheets.first
    puts '------'
    puts sheet_file.row(1)
    puts '------'
  end
end
