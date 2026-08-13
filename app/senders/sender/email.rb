class Sender::Email < Sender::Base
  def deliver(mode = :blast) = MackMailer.blast(@meeting, mode).deliver_later
end
