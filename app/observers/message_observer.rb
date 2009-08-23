class MessageObserver < ActiveRecord::Observer
  def after_create(message)
    UserMailer.deliver_new_message_notification message
  end
end
