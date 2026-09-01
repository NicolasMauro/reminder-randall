module Provider
  # Reads participants for meetings you HOST — pure API, no in-room bot.
  # nil = "can't verify" → Randall still pings and you ack. Wire Zoom/Meet keys to enable auto-detect.
  def self.for(_meeting) = nil
end
