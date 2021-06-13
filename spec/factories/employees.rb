FactoryBot.define do
  factory :employee, class: 'Employee' do
    name { 'John Doe' }
    identification_number { 'COMP1' }
  end
end