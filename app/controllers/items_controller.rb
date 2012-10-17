require 'csv'
class ItemsController < ApplicationController

  def import

  end

  def bulk_create

    if !params[:csv]
      redirect_to :items_import, :notice => "File not provided"
      return
    end

    #TODO -- make memory efficient for large files
    csv_content = CSV.parse(params[:csv].read, :headers => true)

    if csv_content.headers != ["title", "description", "price"]
      redirect_to :items_import, :notice => "Failed uploading, Invalid Format"
      return
    end

    csv_content.each do |row|
      Item.create!(:title => row[0], :description => row[1], :price => row[2])
    end

    render :text => "Success"
  end

end
