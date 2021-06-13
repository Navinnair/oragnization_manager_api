require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { Company.new }

  it { is_expected.not_to be_valid }

  it 'should not allow duplicate identification_number' do
    company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2, identification_number: 'COMP1')
    subject.attributes = {name: 'John Doe', required_employee_count: 1, identification_number: 'COMP1'}
    expect(subject.valid?).not_to be_truthy
  end

  it 'should not allow to delete company with employees' do
    company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2, identification_number: 'COMP1')
    employee = FactoryBot.create(:employee, name: 'Jackson', identification_number: 'C1', company: company)
    response = company.destroy
    expect(response).to eq(false)
  end

end