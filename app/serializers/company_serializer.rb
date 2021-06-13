class CompanySerializer < Blueprinter::Base
  identifier :id

  fields :name, :identification_number, :location, :required_employee_count

  field :parent_company_name do |company, _|
    company.parent.present? ? company.parent.name : ''
  end
end
