require 'test_helper'
describe User do
  it 'import contact file' do
    sheet = create(:sheet)
    User.build_users_from_sheet(sheet.sheet)
  end
end
