require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Api::V1::OrdersController, type: :controller do

    before(:each) {
        request.headers['Accept'] = "application/vnd.todo.com+json; version=1"
        @user = FactoryGirl.create :user
        token = "Token token="+@user.auth_token
        request.headers['Authorization'] = token
    }

    describe "GET #index" do

        before(:each) do
            10.times { FactoryGirl.create :order }
            get :index,format: :json
        end

        it "returns 10 records from the database" do
            orders_response = JSON.parse(response.body, symbolize_names: true)
            expect(orders_response[:orders]).to have(10).items
        end

        it { should respond_with 200}

        its(:content_type) {should == Mime::JSON}

    end

    describe "GET #show" do

        before(:each) do
            product = FactoryGirl.create :product
            token = "Token token="+@user.auth_token
            request.headers['Authorization'] = token
            @order = Order.new
            @order.product_id = product.id
            @order.user_id = @user.id
            @order.amount = 1
            @order.save
            get :show, id: @order.id, format: :json
        end

        it 'returns the product_id of a specific order' do
            order_response = JSON.parse(response.body, symbolize_names: true)
            expect(order_response[:order][:product_id]).to eql @order.product_id
        end

        it 'returns the user_id of a specific order' do
            order_response = JSON.parse(response.body, symbolize_names: true)
            expect(order_response[:order][:user_id]).to eql @order.user_id
        end

        it 'returns the information about the amount of a specific order' do
            order_response = JSON.parse(response.body, symbolize_names: true)
            expect(order_response[:order][:amount]).to eql @order.amount
        end

        it {should respond_with 200}

        its(:content_type) { should == Mime::JSON}
    end

    describe "POST #create" do
        context "when a order is successfully created" do
            before(:each) do
                product = FactoryGirl.create :product
                @post_attributes = FactoryGirl.attributes_for(:order)
                post :create, order: @post_attributes, format: :json
            end

            it "renders the json representation for the post just created" do
                order_response = JSON.parse(response.body, symbolize_names: true)
                expect(order_response[:id]).to eql(@post_attributes[:user_id])
            end

            it { should  respond_with 200 }

        end

        context "when a order fails to be created" do
            before(:each) do
                product = FactoryGirl.create :product
                @post_attributes = FactoryGirl.attributes_for(:order)
                @post_attributes[:amount] = 1000
                post :create, order: @post_attributes, format: :json
            end

            it "renders the error" do
                expect(response.body).to eql("There are only 5 PlayStation 3(s)")
            end

            it { should  respond_with 200 }

        end

    end



end
