module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :load_company, only: %i[show destroy]

      # GET /companies
      def index
        companies = CompaniesQuery.call(query_params)
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

      def query_params
        # less_operative_limit used to filter list of all companies where the amount of employees is less than required
        params.permit(:less_operative_limit)
      end

      def load_company
        @company = Company.find(params[:id])
      end
    end
  end
end
