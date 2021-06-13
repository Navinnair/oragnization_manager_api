FactoryBot.define do
  factory :company, class: 'Company' do
    name { 'Test company' }
    location { 'India' }
    required_employee_count { 10 }
    identification_number { 'COMP1' }
  end
end