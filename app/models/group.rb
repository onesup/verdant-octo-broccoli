class Group < ActiveRecord::Base
  has_many :children, class_name: "Group", foreign_key: "mother_id"
  belongs_to :mother, class_name: "Group"
  before_create :default_nation

  private

  def default_nation
    self.nation = I18n.default_locale.to_s.split('_').last
  end
end
