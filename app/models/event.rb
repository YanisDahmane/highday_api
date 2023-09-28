class Event < ApplicationRecord
  # Get owner of event
  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  # Get members of event
  has_many :event_memberships
  has_many :members, through: :event_memberships, source: :user
end
