class ChangeDefaultvalueForOverallEmployeeCount < ActiveRecord::Migration[6.0]
  def up
    change_column_default :companies, :overall_employees_count, 0
  end

  def down
    change_column_default :companies, :overall_employees_count, nil
  end
end
