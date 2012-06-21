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

describe Recommend::RecommendMtoolsController do

  # This should return the minimal set of attributes required to create a valid
  # Recommend::RecommendMtool. As you add validations to Recommend::RecommendMtool, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Recommend::RecommendMtoolsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all recommend_recommend_mtools as @recommend_recommend_mtools" do
      recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
      get :index, {}, valid_session
      assigns(:recommend_recommend_mtools).should eq([recommend_mtool])
    end
  end

  describe "GET show" do
    it "assigns the requested recommend_recommend_mtool as @recommend_recommend_mtool" do
      recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
      get :show, {:id => recommend_mtool.to_param}, valid_session
      assigns(:recommend_recommend_mtool).should eq(recommend_mtool)
    end
  end

  describe "GET new" do
    it "assigns a new recommend_recommend_mtool as @recommend_recommend_mtool" do
      get :new, {}, valid_session
      assigns(:recommend_recommend_mtool).should be_a_new(Recommend::RecommendMtool)
    end
  end

  describe "GET edit" do
    it "assigns the requested recommend_recommend_mtool as @recommend_recommend_mtool" do
      recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
      get :edit, {:id => recommend_mtool.to_param}, valid_session
      assigns(:recommend_recommend_mtool).should eq(recommend_mtool)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Recommend::RecommendMtool" do
        expect {
          post :create, {:recommend_recommend_mtool => valid_attributes}, valid_session
        }.to change(Recommend::RecommendMtool, :count).by(1)
      end

      it "assigns a newly created recommend_recommend_mtool as @recommend_recommend_mtool" do
        post :create, {:recommend_recommend_mtool => valid_attributes}, valid_session
        assigns(:recommend_recommend_mtool).should be_a(Recommend::RecommendMtool)
        assigns(:recommend_recommend_mtool).should be_persisted
      end

      it "redirects to the created recommend_recommend_mtool" do
        post :create, {:recommend_recommend_mtool => valid_attributes}, valid_session
        response.should redirect_to(Recommend::RecommendMtool.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recommend_recommend_mtool as @recommend_recommend_mtool" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::RecommendMtool.any_instance.stub(:save).and_return(false)
        post :create, {:recommend_recommend_mtool => {}}, valid_session
        assigns(:recommend_recommend_mtool).should be_a_new(Recommend::RecommendMtool)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::RecommendMtool.any_instance.stub(:save).and_return(false)
        post :create, {:recommend_recommend_mtool => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested recommend_recommend_mtool" do
        recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
        # Assuming there are no other recommend_recommend_mtools in the database, this
        # specifies that the Recommend::RecommendMtool created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Recommend::RecommendMtool.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => recommend_mtool.to_param, :recommend_recommend_mtool => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested recommend_recommend_mtool as @recommend_recommend_mtool" do
        recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
        put :update, {:id => recommend_mtool.to_param, :recommend_recommend_mtool => valid_attributes}, valid_session
        assigns(:recommend_recommend_mtool).should eq(recommend_mtool)
      end

      it "redirects to the recommend_recommend_mtool" do
        recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
        put :update, {:id => recommend_mtool.to_param, :recommend_recommend_mtool => valid_attributes}, valid_session
        response.should redirect_to(recommend_mtool)
      end
    end

    describe "with invalid params" do
      it "assigns the recommend_recommend_mtool as @recommend_recommend_mtool" do
        recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::RecommendMtool.any_instance.stub(:save).and_return(false)
        put :update, {:id => recommend_mtool.to_param, :recommend_recommend_mtool => {}}, valid_session
        assigns(:recommend_recommend_mtool).should eq(recommend_mtool)
      end

      it "re-renders the 'edit' template" do
        recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::RecommendMtool.any_instance.stub(:save).and_return(false)
        put :update, {:id => recommend_mtool.to_param, :recommend_recommend_mtool => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested recommend_recommend_mtool" do
      recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
      expect {
        delete :destroy, {:id => recommend_mtool.to_param}, valid_session
      }.to change(Recommend::RecommendMtool, :count).by(-1)
    end

    it "redirects to the recommend_recommend_mtools list" do
      recommend_mtool = Recommend::RecommendMtool.create! valid_attributes
      delete :destroy, {:id => recommend_mtool.to_param}, valid_session
      response.should redirect_to(recommend_recommend_mtools_url)
    end
  end

end
