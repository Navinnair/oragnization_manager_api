require 'rails_helper'

RSpec.describe EmployeeCounterService do
  describe '.call' do
    let(:company1) { FactoryBot.create(:company, name: 'Test A', required_employee_count: 2,
                                       identification_number: 'COMP1') }
    let(:company2) { FactoryBot.create(:company, name: 'Test B', required_employee_count: 1,
                                       identification_number: 'COMP2', parent: company1) }

    context 'when counter type is increment' do
      it 'should increment overall_employees_count in company and its ancestors' do
        company1_current_count = company1.overall_employees_count
        company2_current_count = company2.overall_employees_count
        EmployeeCounterService.call(company2.id, 'increment')
        expect(company1.reload.overall_employees_count).to eq(company1_current_count + 1)
        expect(company2.reload.overall_employees_count).to eq(company2_current_count + 1)
      end

      it 'should not increment overall_employees_count in its descendants' do
        company1_current_count = company1.overall_employees_count
        company2_current_count = company2.overall_employees_count
        EmployeeCounterService.call(company1.id, 'increment')
        expect(company1.reload.overall_employees_count).to eq(company1_current_count + 1)
        expect(company2.reload.overall_employees_count).to eq(company2_current_count.to_i)
      end
    end

    context 'when counter type is decrement' do
      it 'should decrement overall_employees_count in company and its ancestors' do
        company1_current_count = company1.overall_employees_count
        company2_current_count = company2.overall_employees_count
        EmployeeCounterService.call(company2.id, 'decrement')
        expect(company1.reload.overall_employees_count).to eq(company1_current_count - 1)
        expect(company2.reload.overall_employees_count).to eq(company2_current_count - 1)
      end

      it 'should not decrement overall_employees_count in its descendants' do
        company1_current_count = company1.overall_employees_count
        company2_current_count = company2.overall_employees_count
        EmployeeCounterService.call(company1.id, 'decrement')
        expect(company1.reload.overall_employees_count).to eq(company1_current_count - 1)
        expect(company2.reload.overall_employees_count).to eq(company2_current_count)
      end
    end
  end
end