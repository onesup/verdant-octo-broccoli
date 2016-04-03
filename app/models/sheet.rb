class Sheet < ActiveRecord::Base
  mount_uploader :sheet, SheetUploader
end
