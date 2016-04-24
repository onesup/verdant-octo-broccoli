require 'test_helper'
describe Sheet do
  it 'import contact file' do
    sheet = create(:sheet, :contact)
    sheet.build_users_from_sheet
    User.count.must_equal 7
  end

  it 'import holiday file' do
    sheet = create(:sheet, :national_holidays)
    sheet.build_holidays_from_sheet
    Holiday.count.must_equal 4
  end
end
