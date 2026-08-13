class Setting < ApplicationRecord
  belongs_to :user

  CHANNELS = %w[imessage whatsapp call email].freeze

  before_validation { self.channels = Array(channels).compact_blank & CHANNELS }
end
