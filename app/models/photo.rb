class Photo < ApplicationRecord
  scope :visible, ->{ where(visibility: true) }
end
