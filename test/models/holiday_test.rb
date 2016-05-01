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

  it 'Business day 계산' do
    user = create(:user)
    group = create(:group)
    user.group = group
    user.save
    teachers_day = GroupHoliday.new(name: '교사의 날', date: Time.parse('2016-05-15'))
    group.holidays << teachers_day
    long_holiday = Time.parse('2016-05-01')
    requested_holiday = Holiday.new(started_at: long_holiday, finished_at: long_holiday + 21.days)
    user.holidays << requested_holiday
    requested_holiday.actual_vacation_days.must_equal 21.days
  end

  it '휴일 판별' do
    birthday = Time.parse('2016-05-08')
    birthday.holiday?.must_equal false
    NationalHoliday.create(name: '원섭생일', date: birthday)
    birthday.holiday?.must_equal true
  end
end
