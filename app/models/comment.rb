class Comment < ApplicationRecord
  belongs_to :task
  validates :detail, presence: true
end
