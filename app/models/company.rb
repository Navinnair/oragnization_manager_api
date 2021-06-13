class Company < ApplicationRecord
  # to build hierarchical data
  has_closure_tree

  # sub companies association using self join
  belongs_to :parent, class_name: 'Company', optional: true

  has_many :child_companies, class_name: 'Company', foreign_key: 'parent_id'
  has_many :employees

  validates :name, presence: true
  validates :location, presence: true
  validates :required_employee_count, numericality: { only_integer: true, greater_than: 0 }
  validates :identification_number, presence: true
  validates :identification_number, uniqueness: true

  before_destroy :ensure_no_employee_records
  before_destroy :ensure_no_child_company_records

  private

  def ensure_no_employee_records
    if employees.any?
      errors.add(:base, 'cannot delete, employee records found.')
      throw(:abort)
    end
  end

  def ensure_no_child_company_records
    if child_companies.any?
      errors.add(:base, 'cannot delete, child companies found.')
      throw(:abort)
    end
  end
end
