class Holiday < ActiveRecord::Base
  belongs_to :holidayable, polymorphic: true
end
