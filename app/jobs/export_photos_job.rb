require "csv"

class ExportPhotosJob < ApplicationJob
  queue_as :default

  def perform(*args)
    photos = Photo.all
    filename = Rails.root.join("tmp", "all_photos.csv")

    CSV.open(filename, 'w') do |csv|
      csv << Photo::CSV_ATTRIBUTES
      photos.each_with_index do |photo, idx|
        csv << Photo::CSV_ATTRIBUTES.map{ |field| photo.send(field) }

        sleep 0.2

        
        if idx % 5 == 0
          percentage = (idx.to_f / photos.size * 100).round
          Turbo::StreamsChannel.broadcast_replace_to self.job_id, target: self.job_id, partial: "photos/exports/blob_progress",
                                                     locals: { jid: self.job_id, progress: percentage } 
        end
      end
    end
    
    Turbo::StreamsChannel.broadcast_replace_to self.job_id, target: self.job_id, partial: "photos/exports/blob_progress",
                                               locals: { jid: self.job_id, progress: :done } 
  end
end

