class Employee < ApplicationRecord
  belongs_to :company, counter_cache: :employees_count
  # counter_cache - to cache employee count for company

  validates_presence_of :name, :company_id, :identification_number
  validates :identification_number, uniqueness: true
end
