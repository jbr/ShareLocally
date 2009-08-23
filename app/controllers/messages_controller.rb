class MessagesController < ApplicationController
  load_resource :user
  load_resource :message, :by => :id
  before_filter :user_must_be_current
  
  def index
    @messages = @user.incoming_messages
  end
  
  def show
    access_denied unless @message.to_user == current_user
  end
  
  def destroy
    access_denied unless @message.to_user == current_user
    
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.js
    end
  end
end