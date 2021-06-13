class Employee < ApplicationRecord
  belongs_to :company

  validates_presence_of :name, :company_id
  validates :identification_number, uniqueness: true
end
