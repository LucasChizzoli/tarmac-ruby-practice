class Book < ActiveRecord::Base
  validates :isbn, presence: true
  validates :title, presence: true
  validates :releasedate, presence: true
  validates :publisher, presence: true
  validates :website, presence: true
end