class User < ApplicationRecord
  require "securerandom"

  self.inheritance_column = nil

  has_secure_password

  # Get owned events
  has_many :created_events, class_name: 'Event', foreign_key: 'owner_id'

  # Get events where user is a member
  has_many :event_memberships
  has_many :member_events, through: :event_memberships, source: :event

  def all_events(date = nil)
    all_events = created_events + member_events
    if date.present?
      all_events.select { |event| event.start_at.to_date <= date.to_date && event.end_at.to_date >= date.to_date }
    else
      all_events
    end
  end

  validates :firstname, presence: true, on: :create
  validates :lastname, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :create
end