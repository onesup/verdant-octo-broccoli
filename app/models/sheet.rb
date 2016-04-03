class Sheet < ActiveRecord::Base
  mount_uploader :sheet, SheetUploader

  def build_users_from_sheet
    workbook = Roo::Spreadsheet.open(sheet)
    workbook.default_sheet = workbook.sheets.first
    headers = Hash.new
    header_row = 2
    workbook.row(header_row).each_with_index do |header,i|
      headers[header.strip] = i
    end
    ((workbook.first_row + header_row)..workbook.last_row).each do |row|
      email = workbook.row(row)[headers['이메일']]
      phone = workbook.row(row)[headers['전화번호']]
      name = workbook.row(row)[headers['이름']]
      User.find_or_create_by(email: email) do |user|
        user.phone = phone
        user.name = name
      end
    end
  end
end
