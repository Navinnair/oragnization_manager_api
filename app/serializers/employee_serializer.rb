class EmployeeSerializer < Blueprinter::Base
  identifier :id

  fields :name, :identification_number

  field :company_name do |employee, _|
    employee.company.name
  end

end