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

  factory :user do
    name '린드블럼'
    email 'Lindblom@email.com'
    phone '010-8888-8888'
  end

  factory :group do
    name '야구단'
  end
end