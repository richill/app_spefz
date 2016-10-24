class MessagesController < ApplicationController
  #before_action :authenticate_user!

  def inbox
    @inbox = messages.inbox
    @active = :inbox
  end

  def sent
    @sent = messages.sentbox
    @active = :sent
  end

  def trash
    @trash = messages.trash
    @active = :trash
  end
end



