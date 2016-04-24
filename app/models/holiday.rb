class Holiday < ActiveRecord::Base
  belongs_to :holidayable, polymorphic: true

  def date=(the_date)
    self.started_at = the_date.beginning_of_day
    self.finished_at = the_date.end_of_day
  end

  def actual_vacation_days
    finished_at - started_at
  end
end
