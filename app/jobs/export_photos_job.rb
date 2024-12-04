require "csv"

class ExportPhotosJob < ApplicationJob
  queue_as :default

  def perform(*args)
    photos = Photo.all
    filename = Rails.root.join("tmp", "all_photos.csv")

    CSV.open(filename, 'w') do |csv|
      csv << Photo::CSV_ATTRIBUTES
      photos.each do |photo|
        csv << Photo::CSV_ATTRIBUTES.map{ |field| photo.send(field) }

        sleep 0.2
      end
    end

    ActionCable.server.broadcast "export_csv", { jid: self.job_id }
  end
end

