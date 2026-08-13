class User < ApplicationRecord
  has_one :setting, dependent: :destroy
  has_many :meetings, dependent: :destroy
  accepts_nested_attributes_for :setting
  after_create { create_setting! }

  # Single-user self-host. Swap for real auth to go multi-tenant.
  def self.current = first
end
