require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :controller do

  before do
    user = User.create!(name: 'Admin', email: 'admin@mail.com',
                        password: 'admin123' , password_confirmation: 'admin123')
    auth_token = AuthenticateUser.call({email: user.email, password: 'admin123'})
    @request.headers['Authorization'] =  auth_token
  end

  describe '#index' do
    it 'should be success and return company objects' do
      company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2,
                                  identification_number: 'COMP1')

      get :index

      data = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(data['data'].count).to eq(1)
      expect(data['data'][0]['id']).to eq(company.id)
      expect(data['data'][0]['identification_number']).to eq(company.identification_number)
    end

    it 'should be filter records based on less_operative_limit' do
      company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2,
                                  identification_number: 'COMP1', overall_employees_count: 1)
      company2 = FactoryBot.create(:company, name: 'Test B', required_employee_count: 2,
                                   identification_number: 'COMP2', overall_employees_count: 3)

      get :index, params: {less_operative_limit: 'true'}

      data = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(data['data'].count).to eq(1)
      expect(data['data'][0]['id']).to eq(company.id)
      expect(data['data'][0]['identification_number']).to eq(company.identification_number)
    end
  end

  describe '#show' do
    it 'should be success and return company object' do
      company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2,
                                  identification_number: 'COMP1')

      get :show, params: {id: company.id}

      data = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(data['data']['id']).to eq(company.id)
      expect(data['data']['identification_number']).to eq(company.identification_number)
    end

    it 'should throw 404 if record not found' do
      company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2,
                                  identification_number: 'COMP1')

      get :show, params: {id: 100}

      expect(response.status).to eq(404)
    end
  end

  describe '#create' do
    it 'should create company object with request body' do
      get :create, params: {company: {name: 'Test A', required_employee_count: 2,
                                      identification_number: 'COMP1', location: 'India'}
                           }

      data = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(data['data']['identification_number']).to eq('COMP1')
    end
  end

  describe '#destroy' do
    it 'should destroy company object with id' do
      company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2, identification_number: 'COMP1')

      get :destroy, params: {id: company.id}

      expect(response.status).to eq(200)
    end

    it 'should throw 404 if record not found' do
      company = FactoryBot.create(:company, name: 'Test A', required_employee_count: 2,
                                  identification_number: 'COMP1')

      get :destroy, params: {id: 100}

      expect(response.status).to eq(404)
    end
  end

end