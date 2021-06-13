class AddEmployeesCountToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :employees_count, :integer
  end
end
