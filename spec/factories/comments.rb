FactoryGirl.define do
  factory :comment do
    user
    photo
    body "Test Comment"
  end
end
