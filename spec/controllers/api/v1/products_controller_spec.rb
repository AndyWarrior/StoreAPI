require 'rails_helper'

require 'factory_girl_rails'
RSpec.describe Api::V1::ProductsController, type: :controller do

    before(:each) {
        request.headers['Accept'] = "application/vnd.todo.com+json; version=1"
        user = FactoryGirl.create :user
        token = "Token token="+user.auth_token
        request.headers['Authorization'] = token
    }

    describe "GET #index" do

        before(:each) do
            10.times { FactoryGirl.create :product }
            get :index,format: :json
        end

        it "returns 10 records from the database" do
            products_response = JSON.parse(response.body, symbolize_names: true)
            expect(products_response[:products]).to have(10).items
        end

        it { should respond_with 200}

        its(:content_type) {should == Mime::JSON}

    end

    describe "GET #show" do

        before(:each) do
            @product = FactoryGirl.create :product
            get :show, id: @product.id, format: :json
        end

        it 'returns the information about a specific product' do
            product_response = JSON.parse(response.body, symbolize_names: true)
            expect(product_response[:product][:name]).to eql @product.name
        end

        it 'returns the information about the image_url of a specific product' do
            product_response = JSON.parse(response.body, symbolize_names: true)
            expect(product_response[:product][:image_url]).to eql @product.image_url
        end

        it 'returns the information about the available of a specific product' do
            product_response = JSON.parse(response.body, symbolize_names: true)
            expect(product_response[:product][:available]).to eql @product.available
        end

        it 'returns the information about the description of a specific product' do
            product_response = JSON.parse(response.body, symbolize_names: true)
            expect(product_response[:product][:description]).to eql @product.description
        end

        it {should respond_with 200}

        its(:content_type) { should == Mime::JSON}
    end

    describe "DELETE #destroy" do

        before(:each) do
            @product = FactoryGirl.create :product
            post :destroy, id: @product.id, format: :json
        end


        it { should  respond_with 204 }
    end

    describe "POST #create" do
        context "when a p is successfully created" do
            before(:each) do
                @post_attributes = FactoryGirl.attributes_for(:product)
                post :create, product: @post_attributes, format: :json
            end

            it "renders the json representation for the post just created" do
                product_response = JSON.parse(response.body, symbolize_names: true)
                expect(product_response[:product][:name]).to eql(@post_attributes[:name])
            end

            it { should  respond_with 200 }

        end
    end

end
