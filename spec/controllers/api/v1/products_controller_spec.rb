require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Api::V1::ProductsController, type: :controller do

    before(:each) {
        request.headers['Accept'] = "application/vnd.todo.com+json; version=1"
        user = FactoryGirl.create :user
        token = "Token token="+user.auth_token
    }

    describe "GET #index" do

        before(:each) do
            10.times { FactoryGirl.create :product }
            get :index,{token} ,format: :json      
        end




        it "returns 10 records from the database" do
            products_response = JSON.parse(response.body, symbolize_names: true)
            print products_response.inspect
            expect(products_response[:tasks].size) == 10
        end

    end

end
