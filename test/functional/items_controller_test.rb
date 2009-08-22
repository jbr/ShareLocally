require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class ItemsControllerTest < ActionController::TestCase
  context 'with an existing item' do
    setup {@item = Item.first}
    context "on GET to :show" do
      setup { get :show, :id => @item.to_param }
      should_assign_to :item
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end

    context "on POST to :update" do
      setup { post :update, :id => @item.to_param, :item => {} }
      should_assign_to :item
      should_redirect_to("the item") { item_url @item}
    end
  end
end
