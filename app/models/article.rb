class Article < ApplicationRecord
  belongs_to :user
  # associated with specific user and validates that it at least has a title
  validates_presence_of :title
end
