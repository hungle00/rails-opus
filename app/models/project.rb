class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true

  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
end
