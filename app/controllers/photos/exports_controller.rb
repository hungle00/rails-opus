class Photos::ExportsController < ApplicationController
  def index
    job = ExportPhotosJob.perform_later
    @jid = job.job_id
  end

  def download
    job_id = params[:id]
    filename = "All_photos_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.csv"

    respond_to do |format|
      format.csv do
        send_file Rails.root.join("tmp", "all_photos.csv"), type: :csv, filename: filename
      end
    end
  end
end
