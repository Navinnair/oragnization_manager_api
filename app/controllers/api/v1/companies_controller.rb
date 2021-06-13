class Api::V1::CompaniesController < ApplicationController
  before_action :load_company, only: [ :show, :destroy ]

  # GET /companies
  def index
    companies = Company.all
    render json: { data: CompanySerializer.render_as_json(companies) }
  end

  # GET /company/:id
  def show
    render json: { data: CompanySerializer.render_as_json(@company) }
  end

  # POST /companies
  def create
    company = Company.new(company_params)
    if company.save
      render json: { data: CompanySerializer.render_as_json(company) }
    else
      render json: { errors: company.errors.messages }, status: 400
    end
  end

  # DELETE /company/:id
  def destroy
    if @company.destroy
      render json: { message: 'Successfully deleted' }
    else
      render json: { errors: @company.errors.messages }, status: 400
    end
  end


  private

  def company_params
    params.require(:company).permit(:name, :identification_number, :location, :required_employee_count, :parent_id)
  end

  def load_company
    @company = Company.find(params[:id])
  end

end
