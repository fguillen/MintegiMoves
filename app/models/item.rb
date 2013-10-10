class Item < ActiveRecord::Base
  strip_attributes
  log_book

  has_many :pics, :as => :picable
  belongs_to :category

  attr_protected nil

  before_validation :initialize_position

  validates :title, :presence => true, :uniqueness => true
  validates :text, :presence => true
  validates :position, :presence => true
  validates :category_id, :presence => true

  scope :by_position, order("position asc")

  def initialize_position
    self.position ||= Item.minimum(:position).to_i - 1
  end

  def to_param
    "#{id}-#{title.to_url}"
  end
end
