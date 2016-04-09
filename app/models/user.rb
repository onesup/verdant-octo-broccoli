class User < ActiveRecord::Base
  has_many :holidays, as: :holidayable
end
