class User < ApplicationRecord
  require "securerandom"

  self.inheritance_column = nil

  has_secure_password

  validates :firstname, presence: true, on: :create
  validates :lastname, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :create
end