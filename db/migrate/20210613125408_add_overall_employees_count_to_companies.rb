class AddOverallEmployeesCountToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :overall_employees_count, :integer
  end
end
