module Sender
  # Sender.for("imessage", meeting) => Sender::Imessage.new(meeting)
  def self.for(channel, meeting) = const_get(channel.camelize).new(meeting)

  class Base
    def initialize(meeting) = @meeting = meeting
    def deliver(mode = :blast) = raise NotImplementedError

    private
      def body(mode) = Copy.text(@meeting, mode)
      def user = @meeting.user
  end
end
