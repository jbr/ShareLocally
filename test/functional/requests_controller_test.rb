require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class RequestsControllerTest < ActionController::TestCase
  context 'with an existing request' do
    setup {@request = Request.first}
    context "on GET to :show" do
      setup { get :show, :id => @request.to_param }
      should_assign_to :request
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end

    context "on POST to :update" do
      setup { post :update, :id => @request.to_param, :request => {} }
      should_assign_to :request
      should_redirect_to("the request") { request_url @request}
    end
  end
end
