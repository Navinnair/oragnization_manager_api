class Employee < ApplicationRecord
  belongs_to :company

  validates_presence_of :name, :company_id, :identification_number
  validates :identification_number, uniqueness: true
end
