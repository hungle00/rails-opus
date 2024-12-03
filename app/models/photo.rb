require "csv"

class Photo < ApplicationRecord
  CSV_ATTRIBUTES = %w(id name url description likes_count).freeze

  scope :visible, ->{ where.not(url: true) }

  class << self
  	# this method should be defined in service class
    def export_data
	  CSV.generate do |csv|
	    csv << CSV_ATTRIBUTES
	    Photo.all.each do |photo|
	      csv << CSV_ATTRIBUTES.map{ |field| photo.send(field) }
	    end
	  end
    end
  end
end
