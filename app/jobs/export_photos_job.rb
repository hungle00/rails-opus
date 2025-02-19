require "csv"

class ExportPhotosJob < ApplicationJob
  queue_as :default

  def perform(*args)
    photos = Photo.all
    filename = Rails.root.join("tmp", "all_photos.csv")

    CSV.open(filename, "w") do |csv|
      csv << Photo::CSV_ATTRIBUTES
      photos.each_with_index do |photo, idx|
        csv << Photo::CSV_ATTRIBUTES.map { |field| photo.send(field) }

        sleep 0.2

        if idx % 5 == 0
          percentage = (idx.to_f / photos.size * 100).round
          ActionCable.server.broadcast "export_csv", { progress: percentage }
        end
      end
    end

    ActionCable.server.broadcast "export_csv", { jid: self.job_id }
  end
end
