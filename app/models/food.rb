class Food < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :properties

  before_validation :set_uuid, :on => :create

  def to_param
    self.uuid
  end

  def as_json(options)
    super(:except => [:id], :include => :properties)
  end

  private
  def set_uuid
    self.uuid = UUIDTools::UUID.timestamp_create.to_s
  end
end
