class User < ActiveRecord::Base
  has_many :holidays, as: :holidayable
  belongs_to :group
end
