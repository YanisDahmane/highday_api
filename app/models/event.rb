class Event < ApplicationRecord
  # Get owner of event
  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  # Get members of event
  has_many :event_memberships
  has_many :members, through: :event_memberships, source: :user

  validates :title, presence: true, on: :create
  validates :description, presence: true, on: :create
  validates :start_at, presence: true, on: :create
  validates :end_at, presence: true, on: :create

end
