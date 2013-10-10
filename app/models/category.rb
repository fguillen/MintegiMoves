class Category < ActiveRecord::Base
  strip_attributes
  log_book

  has_many :pics, :as => :picable
  has_many :items

  attr_protected nil

  before_validation :initialize_position

  validates :title, :presence => true, :uniqueness => true
  validates :text, :presence => true
  validates :position, :presence => true

  scope :by_position, order("position asc")

  def initialize_position
    self.position ||= Category.minimum(:position).to_i - 1
  end

  def to_param
    "#{id}-#{title.to_url}"
  end
end
