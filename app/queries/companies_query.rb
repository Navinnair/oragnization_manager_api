class CompaniesQuery < ApplicationQuery
  def initialize(query_params = {})
    @query_params = query_params
  end

  def call
    list_companies
  end

  private

  attr_reader :query_params

  def list_companies
    valid_filters? ? filtered_list : companies
  end

  def companies
    @_companies ||= Company.all
  end

  # list of all companies where the amount of employees is less than required
  def filtered_list
    companies.where('overall_employees_count < required_employee_count')
  end

  def valid_filters?
    query_params[:less_operative_limit] == 'true'
  end
end
