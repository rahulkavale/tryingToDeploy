require 'fabrication'
require "spec_helper"

describe ItemsController do

  include Devise::TestHelpers

  before :each do
    @user = Fabricate(:user)
    sign_in @user
  end

  context "routes" do
    it "should route requests correctly" do
      {:get => '/items/index'}.should route_to('items#index')
      {:get => '/items/import'}.should route_to('items#import')
      {:post => '/items/import'}.should route_to('items#bulk_create')
      {:get => '/items/random-slug'}.should route_to('items#show', :slug => "random-slug")
    end
  end

  context "Bulk create items from CSV file upload" do
    it "GET 'show_import_form' should be successful" do
      get :import
      response.should be_success
      response.should render_template(:import)
    end

    it "bulk creation should create items" do
      post :bulk_create, "csv" => Rack::Test::UploadedFile.new("spec/fixtures/items.csv", "text/csv")
      Item.count.should_not equal(0)
      Item.count.should equal 2
      response.body.should == "Success"
    end


    {"invalid file type" => "spec/fixtures/favicon.ico",
     "invalid file format" => "spec/fixtures/malformed_data.csv"}.each do |type, filename|

      it "bulk creation should fail for #{type}" do
        post :bulk_create, "csv" => Rack::Test::UploadedFile.new(filename, "text/csv")
        response.should redirect_to(:items_import)
        flash[:notice].should include("Failed uploading, Invalid Format")
      end
    end

    it "bulk creation should fail if file not provided" do
      post :bulk_create, "csv" => nil
      response.should redirect_to(:items_import)
      flash[:notice].should include("File not provided")
    end
  end

  context "browse" do
    it "should show the items" do
      item = Fabricate(:item)
      get :index
      assigns[:items].should == [item]
      response.should be_success
    end
  end

  context "show" do
    it "GET 'show' should be successful" do
      item = Fabricate(:item)
      get :show, :slug => item.slug
      response.should be_success
      response.should render_template(:show)
    end

    it "GET 'show' should redirect to 404 if item not found" do
      get :show, :slug => "test"
      response.should redirect_to("/404.html")
    end
  end
end

