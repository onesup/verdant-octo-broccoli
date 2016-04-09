require 'test_helper'
describe Holiday do
  it 'holiday belongs user' do
    user = User.new(name: '이원섭')
    holiday = Holiday.new(name: '어버이날')
    user.holidays << holiday
    user.holidays.map(&:name).join.must_equal holiday.name
    user = User.new(name: '박찬호')
    holiday.holidayable = user
    holiday.holidayable.name.must_equal user.name
  end
end
