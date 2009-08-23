require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class MessagesControllerTest < ActionController::TestCase
  context 'with an existing message' do
    setup {@message = Message.first}
    context "on GET to :show" do
      setup { get :show, :id => @message.to_param }
      should_assign_to :message
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end

    context "on POST to :update" do
      setup { post :update, :id => @message.to_param, :message => {} }
      should_assign_to :message
      should_redirect_to("the message") { message_url @message}
    end
  end
end
