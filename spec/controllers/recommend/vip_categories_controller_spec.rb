require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Recommend::VipCategoriesController do

  # This should return the minimal set of attributes required to create a valid
  # Recommend::VipCategory. As you add validations to Recommend::VipCategory, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Recommend::VipCategoriesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all recommend_vip_categories as @recommend_vip_categories" do
      vip_category = Recommend::VipCategory.create! valid_attributes
      get :index, {}, valid_session
      assigns(:recommend_vip_categories).should eq([vip_category])
    end
  end

  describe "GET show" do
    it "assigns the requested recommend_vip_category as @recommend_vip_category" do
      vip_category = Recommend::VipCategory.create! valid_attributes
      get :show, {:id => vip_category.to_param}, valid_session
      assigns(:recommend_vip_category).should eq(vip_category)
    end
  end

  describe "GET new" do
    it "assigns a new recommend_vip_category as @recommend_vip_category" do
      get :new, {}, valid_session
      assigns(:recommend_vip_category).should be_a_new(Recommend::VipCategory)
    end
  end

  describe "GET edit" do
    it "assigns the requested recommend_vip_category as @recommend_vip_category" do
      vip_category = Recommend::VipCategory.create! valid_attributes
      get :edit, {:id => vip_category.to_param}, valid_session
      assigns(:recommend_vip_category).should eq(vip_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Recommend::VipCategory" do
        expect {
          post :create, {:recommend_vip_category => valid_attributes}, valid_session
        }.to change(Recommend::VipCategory, :count).by(1)
      end

      it "assigns a newly created recommend_vip_category as @recommend_vip_category" do
        post :create, {:recommend_vip_category => valid_attributes}, valid_session
        assigns(:recommend_vip_category).should be_a(Recommend::VipCategory)
        assigns(:recommend_vip_category).should be_persisted
      end

      it "redirects to the created recommend_vip_category" do
        post :create, {:recommend_vip_category => valid_attributes}, valid_session
        response.should redirect_to(Recommend::VipCategory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recommend_vip_category as @recommend_vip_category" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::VipCategory.any_instance.stub(:save).and_return(false)
        post :create, {:recommend_vip_category => {}}, valid_session
        assigns(:recommend_vip_category).should be_a_new(Recommend::VipCategory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::VipCategory.any_instance.stub(:save).and_return(false)
        post :create, {:recommend_vip_category => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested recommend_vip_category" do
        vip_category = Recommend::VipCategory.create! valid_attributes
        # Assuming there are no other recommend_vip_categories in the database, this
        # specifies that the Recommend::VipCategory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Recommend::VipCategory.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => vip_category.to_param, :recommend_vip_category => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested recommend_vip_category as @recommend_vip_category" do
        vip_category = Recommend::VipCategory.create! valid_attributes
        put :update, {:id => vip_category.to_param, :recommend_vip_category => valid_attributes}, valid_session
        assigns(:recommend_vip_category).should eq(vip_category)
      end

      it "redirects to the recommend_vip_category" do
        vip_category = Recommend::VipCategory.create! valid_attributes
        put :update, {:id => vip_category.to_param, :recommend_vip_category => valid_attributes}, valid_session
        response.should redirect_to(vip_category)
      end
    end

    describe "with invalid params" do
      it "assigns the recommend_vip_category as @recommend_vip_category" do
        vip_category = Recommend::VipCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::VipCategory.any_instance.stub(:save).and_return(false)
        put :update, {:id => vip_category.to_param, :recommend_vip_category => {}}, valid_session
        assigns(:recommend_vip_category).should eq(vip_category)
      end

      it "re-renders the 'edit' template" do
        vip_category = Recommend::VipCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::VipCategory.any_instance.stub(:save).and_return(false)
        put :update, {:id => vip_category.to_param, :recommend_vip_category => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested recommend_vip_category" do
      vip_category = Recommend::VipCategory.create! valid_attributes
      expect {
        delete :destroy, {:id => vip_category.to_param}, valid_session
      }.to change(Recommend::VipCategory, :count).by(-1)
    end

    it "redirects to the recommend_vip_categories list" do
      vip_category = Recommend::VipCategory.create! valid_attributes
      delete :destroy, {:id => vip_category.to_param}, valid_session
      response.should redirect_to(recommend_vip_categories_url)
    end
  end

end