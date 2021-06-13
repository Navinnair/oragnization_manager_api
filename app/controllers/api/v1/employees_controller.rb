class Api::V1::EmployeesController < ApplicationController
  before_action :load_company
  before_action :load_employee, only: [ :show, :destroy ]

  # GET /employee/:id
  def show
    render json: { data: EmployeeSerializer.render_as_json(@employee) }
  end

  # POST /employees
  def create
    employee = @company.employees.build(employee_params)
    if employee.save
      render json: { data: EmployeeSerializer.render_as_json(employee) }
    else
      render json: { errors: employee.errors.messages }, status: 400
    end
  end

  # DELETE /employee/:id
  def destroy
    if @employee.destroy
      render json: { message: 'Successfully deleted' }
    else
      render json: { errors: @employee.errors.messages }, status: 400
    end
  end


  private

  def employee_params
    params.require(:employee).permit(:name, :identification_number)
  end

  def load_employee
    @employee = @company.employees.find(params[:id])
  end

  def load_company
    @company = Company.find(params[:company_id])
  end
end
