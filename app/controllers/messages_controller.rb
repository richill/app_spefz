class MessagesController < ApplicationController
  #before_action :authenticate_user!

  def inbox
    @inbox = message.inbox
    @active = :inbox
  end

  def sent
    @sent = message.sentbox
    @active = :sent
  end

  def trash
    @trash = message.trash
    @active = :trash
  end
end



