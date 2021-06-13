# this will trigger on employee
# after_save: increment the count for the current company and ancestors
# after destroy: decrement the count for the current company and ancestors

class EmployeeCounterWorker
  include Sidekiq::Worker

  def perform(company_id, counter_type)
    EmployeeCounterService.call(company_id, counter_type)
  end
end
