require 'test_helper'
describe Sheet do
  it 'import contact file' do
    sheet = create(:sheet)
    sheet.build_users_from_sheet
    User.count.must_equal 7
  end
end
