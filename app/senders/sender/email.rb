class Sender::Email < Sender::Base
  def deliver(mode = :blast) = RandallMailer.blast(@meeting, mode).deliver_later
end
