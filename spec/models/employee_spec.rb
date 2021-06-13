require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { Employee.new }

  it { is_expected.not_to be_valid }

  it 'should not allow duplicate identification_number' do
    company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2, identification_number: 'COMP1')
    employee = FactoryBot.create(:employee, name: 'Jackson', identification_number: 'C1', company: company)
    subject.attributes = {company_id: company.id, name: 'John Doe', identification_number: 'C1'}
    expect(subject.valid?).not_to be_truthy
  end

end