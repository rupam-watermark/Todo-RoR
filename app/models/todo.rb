class Todo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :status, type: String
  field :tags, type: String
  field :view, type: Boolean, default: true

  validates :title, presence: true

end
