class MackMailer < ApplicationMailer
  def blast(meeting, mode = :blast)
    @meeting, @mode = meeting, mode
    mail to: meeting.user.email, subject: Copy.subject(meeting, mode)
  end
end
