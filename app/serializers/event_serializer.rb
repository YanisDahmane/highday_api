class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_at, :end_at, :owner_id
  has_many :members, serializer: UserSerializer
  belongs_to :owner, serializer: UserSerializer
end