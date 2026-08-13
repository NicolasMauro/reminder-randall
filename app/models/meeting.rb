class Meeting < ApplicationRecord
  belongs_to :user
  has_secure_token
  delegate :setting, to: :user

  scope :pending, -> { where(acknowledged_at: nil) }

  def ack! = acknowledged? || update!(acknowledged_at: Time.current)
  def acknowledged? = acknowledged_at?
  def joined? = (hosting? && Provider.for(self)&.joined?) || false
  def needs_blast? = !acknowledged? && !joined?
  def minutes_late = [ ((Time.current - starts_at) / 60).round, 0 ].max

  # One scheduled check at start+grace; escalation self-chains from there.
  def schedule!
    return if acknowledged?
    EscalateJob.set(wait_until: starts_at + setting.grace_minutes.minutes).perform_later(id)
    LeadReminderJob.set(wait_until: starts_at - setting.lead_minutes.minutes).perform_later(id) if setting.lead_minutes
  end
end
