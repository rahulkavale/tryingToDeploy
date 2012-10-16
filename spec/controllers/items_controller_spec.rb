require "rspec"
require "spec_helper"

describe ItemsController do
  it "GET 'show_import_form' should be successful" do
    get :bulk_import_form
    response.should be_success
    response.should render_template(:import)
  end

  it "bulk creation should create items" do
    post :bulk_create, "csv" => Rack::Test::UploadedFile.new("spec/fixtures/items.csv", "text/csv")
    Item.count.should_not equal(0)
    Item.count.should equal 2
    response.body.should == "Success"
  end

  it "bulk creation should fail for improperly formatted csv files" do
    post :bulk_create, "csv" => Rack::Test::UploadedFile.new("spec/fixtures/malformed_data.csv", "text/csv")
    response.body.should == "Failed uploading, Invalid Format"
  end

  it "bulk creation should fail for non csv files" do
    post :bulk_create, "csv" => Rack::Test::UploadedFile.new("spec/fixtures/favicon.ico", "text/csv")
    response.body.should == "Failed uploading, Invalid Format"
  end
end

