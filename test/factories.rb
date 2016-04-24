FactoryGirl.define do
  factory :sheet do
    file_path = "#{Rails.root}/test/fixtures/files/"
    trait :contact do
      file_name = "연락처.xlsx"
      sheet { Rack::Test::UploadedFile.new(file_path + file_name) }
    end

    trait :national_holidays do
      file_name = "국가공휴일.xlsx"
      sheet { Rack::Test::UploadedFile.new(file_path + file_name) }
    end
  end
end