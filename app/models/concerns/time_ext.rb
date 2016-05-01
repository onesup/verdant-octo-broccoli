module TimeExt
  extend ActiveSupport::Concern

  def holiday?
    NationalHoliday.all.map(&:date).include? self.to_date
  end
end