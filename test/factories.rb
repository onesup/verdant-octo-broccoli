FactoryGirl.define do
  factory :sheet do
    file_path = "#{Rails.root}/test/fixtures/files/연락처.xlsx"
    sheet { Rack::Test::UploadedFile.new(file_path) }
  end
end
