class Photos::ExportsController < ApplicationController
  def index
  	csv_data = Photo.export_data
  	filename = "All_photos_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.csv"

    respond_to do |format|
      format.csv do
      	send_data csv_data, type: :csv, filename: filename
      end
    end
  end
end