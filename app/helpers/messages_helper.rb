module MessagesHelper

  def unread_messages_count
    # how to get the number of unread messages for the current_user
    # using mailboxer
    message.inbox(unread: true).count(:id, distinct: true)
  end

  def sent_messages_count
    message.sentbox.count(:id, distinct: true)
  end

  def trashed_messages_count
    message.trash.count(:id, distinct: true)
  end
end



