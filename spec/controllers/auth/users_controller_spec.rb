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

describe Auth::UsersController do

  # This should return the minimal set of attributes required to create a valid
  # Auth::User. As you add validations to Auth::User, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Auth::UsersController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all auth_users as @auth_users" do
      user = Auth::User.create! valid_attributes
      get :index, {}, valid_session
      assigns(:auth_users).should eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested auth_user as @auth_user" do
      user = Auth::User.create! valid_attributes
      get :show, {:id => user.to_param}, valid_session
      assigns(:auth_user).should eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new auth_user as @auth_user" do
      get :new, {}, valid_session
      assigns(:auth_user).should be_a_new(Auth::User)
    end
  end

  describe "GET edit" do
    it "assigns the requested auth_user as @auth_user" do
      user = Auth::User.create! valid_attributes
      get :edit, {:id => user.to_param}, valid_session
      assigns(:auth_user).should eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Auth::User" do
        expect {
          post :create, {:auth_user => valid_attributes}, valid_session
        }.to change(Auth::User, :count).by(1)
      end

      it "assigns a newly created auth_user as @auth_user" do
        post :create, {:auth_user => valid_attributes}, valid_session
        assigns(:auth_user).should be_a(Auth::User)
        assigns(:auth_user).should be_persisted
      end

      it "redirects to the created auth_user" do
        post :create, {:auth_user => valid_attributes}, valid_session
        response.should redirect_to(Auth::User.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved auth_user as @auth_user" do
        # Trigger the behavior that occurs when invalid params are submitted
        Auth::User.any_instance.stub(:save).and_return(false)
        post :create, {:auth_user => {}}, valid_session
        assigns(:auth_user).should be_a_new(Auth::User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Auth::User.any_instance.stub(:save).and_return(false)
        post :create, {:auth_user => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested auth_user" do
        user = Auth::User.create! valid_attributes
        # Assuming there are no other auth_users in the database, this
        # specifies that the Auth::User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Auth::User.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => user.to_param, :auth_user => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested auth_user as @auth_user" do
        user = Auth::User.create! valid_attributes
        put :update, {:id => user.to_param, :auth_user => valid_attributes}, valid_session
        assigns(:auth_user).should eq(user)
      end

      it "redirects to the auth_user" do
        user = Auth::User.create! valid_attributes
        put :update, {:id => user.to_param, :auth_user => valid_attributes}, valid_session
        response.should redirect_to(user)
      end
    end

    describe "with invalid params" do
      it "assigns the auth_user as @auth_user" do
        user = Auth::User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Auth::User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :auth_user => {}}, valid_session
        assigns(:auth_user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        user = Auth::User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Auth::User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :auth_user => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested auth_user" do
      user = Auth::User.create! valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}, valid_session
      }.to change(Auth::User, :count).by(-1)
    end

    it "redirects to the auth_users list" do
      user = Auth::User.create! valid_attributes
      delete :destroy, {:id => user.to_param}, valid_session
      response.should redirect_to(auth_users_url)
    end
  end

end