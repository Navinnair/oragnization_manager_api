class Employee < ApplicationRecord
  belongs_to :company, counter_cache: :employees_count
  # counter_cache - to cache employee count for company

  validates_presence_of :name, :company_id, :identification_number
  validates :identification_number, uniqueness: true

  after_create :increment_all_employee_count
  after_destroy :decrement_all_employee_count

  private

  # increment the count for the employees current company and ancestors
  def increment_all_employee_count
    EmployeeCounterWorker.perform_in(5.seconds, company_id, 'increment')
  end

  # decrement the count for the employees current company and ancestors
  def decrement_all_employee_count
    EmployeeCounterWorker.perform_in(5.seconds, company_id, 'decrement')
  end
end
