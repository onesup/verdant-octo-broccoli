class Sheet < ActiveRecord::Base
  mount_uploader :sheet, SheetUploader
  attr_accessor :workbook

  def workbook
    Roo::Spreadsheet.open(sheet)
  end

  def build_users_from_sheet
    workbook.default_sheet = workbook.sheets.first
    headers = Hash.new
    workbook.row(build_users_header_row).each_with_index do |header,i|
      headers[header.strip] = i
    end
    ((workbook.first_row + build_users_header_row)..workbook.last_row).each do |row|
      email = workbook.row(row)[headers['이메일']]
      phone = workbook.row(row)[headers['전화번호']]
      name = workbook.row(row)[headers['이름']]
      User.find_or_create_by(email: email) do |user|
        user.phone = phone
        user.name = name
      end
    end
  end

  def build_users_header_row
    Phonelib.default_country = "kr"
    (workbook.first_row..workbook.last_row).each do |row|
      return row - 1 if workbook.row(row).map{ |r| Phonelib.parse(r).valid? }.include?(true)
    end
  end

  def build_holidays_header_row
    (workbook.first_row..workbook.last_row).each do |row|
      return row - 1 if workbook.row(row).map{ |r| Date._parse(r.to_s).present? }.include?(true)
    end
  end

  def build_holidays_from_sheet(holiday_type = 'national_holiday')
    workbook.default_sheet = workbook.sheets.first
    headers = Hash.new
    workbook.row(build_holidays_header_row).each_with_index do |header,i|
      headers[header.strip] = i
    end
    ((workbook.first_row + build_holidays_header_row)..workbook.last_row).each do |row|
      date = workbook.row(row)[headers['날짜']]
      name = workbook.row(row)[headers['이름']]
      holiday_class = holiday_type.classify.constantize
      holiday_class.find_or_create_by(started_at: date.beginning_of_day) do |holiday|
        holiday.name = name
        holiday.started_at = date.beginning_of_day
        holiday.finished_at = date.end_of_day
      end
    end
  end
end
