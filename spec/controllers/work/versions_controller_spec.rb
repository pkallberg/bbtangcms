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

describe Work::VersionsController do

  # This should return the minimal set of attributes required to create a valid
  # Work::Version. As you add validations to Work::Version, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Work::VersionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all work_versions as @work_versions" do
      version = Work::Version.create! valid_attributes
      get :index, {}, valid_session
      assigns(:work_versions).should eq([version])
    end
  end

  describe "GET show" do
    it "assigns the requested work_version as @work_version" do
      version = Work::Version.create! valid_attributes
      get :show, {:id => version.to_param}, valid_session
      assigns(:work_version).should eq(version)
    end
  end

  describe "GET new" do
    it "assigns a new work_version as @work_version" do
      get :new, {}, valid_session
      assigns(:work_version).should be_a_new(Work::Version)
    end
  end

  describe "GET edit" do
    it "assigns the requested work_version as @work_version" do
      version = Work::Version.create! valid_attributes
      get :edit, {:id => version.to_param}, valid_session
      assigns(:work_version).should eq(version)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Work::Version" do
        expect {
          post :create, {:work_version => valid_attributes}, valid_session
        }.to change(Work::Version, :count).by(1)
      end

      it "assigns a newly created work_version as @work_version" do
        post :create, {:work_version => valid_attributes}, valid_session
        assigns(:work_version).should be_a(Work::Version)
        assigns(:work_version).should be_persisted
      end

      it "redirects to the created work_version" do
        post :create, {:work_version => valid_attributes}, valid_session
        response.should redirect_to(Work::Version.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved work_version as @work_version" do
        # Trigger the behavior that occurs when invalid params are submitted
        Work::Version.any_instance.stub(:save).and_return(false)
        post :create, {:work_version => {}}, valid_session
        assigns(:work_version).should be_a_new(Work::Version)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Work::Version.any_instance.stub(:save).and_return(false)
        post :create, {:work_version => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested work_version" do
        version = Work::Version.create! valid_attributes
        # Assuming there are no other work_versions in the database, this
        # specifies that the Work::Version created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Work::Version.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => version.to_param, :work_version => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested work_version as @work_version" do
        version = Work::Version.create! valid_attributes
        put :update, {:id => version.to_param, :work_version => valid_attributes}, valid_session
        assigns(:work_version).should eq(version)
      end

      it "redirects to the work_version" do
        version = Work::Version.create! valid_attributes
        put :update, {:id => version.to_param, :work_version => valid_attributes}, valid_session
        response.should redirect_to(version)
      end
    end

    describe "with invalid params" do
      it "assigns the work_version as @work_version" do
        version = Work::Version.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Work::Version.any_instance.stub(:save).and_return(false)
        put :update, {:id => version.to_param, :work_version => {}}, valid_session
        assigns(:work_version).should eq(version)
      end

      it "re-renders the 'edit' template" do
        version = Work::Version.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Work::Version.any_instance.stub(:save).and_return(false)
        put :update, {:id => version.to_param, :work_version => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested work_version" do
      version = Work::Version.create! valid_attributes
      expect {
        delete :destroy, {:id => version.to_param}, valid_session
      }.to change(Work::Version, :count).by(-1)
    end

    it "redirects to the work_versions list" do
      version = Work::Version.create! valid_attributes
      delete :destroy, {:id => version.to_param}, valid_session
      response.should redirect_to(work_versions_url)
    end
  end

end