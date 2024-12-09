require "csv"

class Photo < ApplicationRecord
  CSV_ATTRIBUTES = %w(id name url description likes_count).freeze

  scope :visible, ->{ where.not(url: true) }
end
