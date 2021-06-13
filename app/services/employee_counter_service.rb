# service to manage and cache the total employees count in employee table (company + all the descendants).
# after_save: increment the count for the current company and ancestors
# after destroy: decrement the count for the current company and ancestors

class EmployeeCounterService < ApplicationService
  def initialize(company_id, counter_type)
    @company_id = company_id
    @counter_type = counter_type
  end

  # Service entry point
  def call
    call_counter
  end

  private

  attr_reader :company_id, :counter_type

  def call_counter
    company.self_and_ancestors.each do |record|
      # method will be increment_count || decrement_count
      new_count = method("#{counter_type}_count").call(record.overall_employees_count)
      record.update_column(:overall_employees_count, new_count)
    end
  end

  # increment the count for the current company and ancestors
  def increment_count(current_count)
    current_count.to_i + 1
  end

  # decrement the count for the current company and ancestors
  def decrement_count(current_count)
    current_count.to_i - 1
  end

  # set company
  def company
    Company.find(company_id)
  end
end
