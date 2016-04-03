class Sheet < ActiveRecord::Base
  mount_uploader :sheet, SheetUploader
  attr_accessor :workbook

  def workbook
    Roo::Spreadsheet.open(sheet)
  end

  def build_users_from_sheet
    workbook.default_sheet = workbook.sheets.first
    headers = Hash.new
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

  def header_row
    Phonelib.default_country = "KR"
    (workbook.first_row..workbook.last_row).each do |row|
      return row - 1 if workbook.row(row).map{ |r| Phonelib.parse(r).valid? }.include?(true)
    end
  end
end
