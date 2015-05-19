require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
    before(:each) {
        request.headers['Accept'] = "application/vnd.todo.com+json; version=1"
    }

    before(:each) do
        10.times { FactoryGirl.create :task }
        get :index, format: :JSON
    end


end
