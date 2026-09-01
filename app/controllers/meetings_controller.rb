class MeetingsController < ApplicationController
  def index = (@meetings = current_user.meetings.where("starts_at > ?", 1.hour.ago).order(:starts_at))

  # Magic-link ack from the reminder text/email.
  def ack
    Meeting.find_by!(token: params[:token]).ack!
    render plain: "🥊 Got it — Randall will leave you alone. You can close this."
  end
end
