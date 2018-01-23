FactoryGirl.define do
    factory :blog do
        title {Faker::Dog.name}
    end
end