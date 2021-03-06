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

describe Work::AnalyticsController do

  # This should return the minimal set of attributes required to create a valid
  # Work::Analytic. As you add validations to Work::Analytic, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Work::AnalyticsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all work_analytics as @work_analytics" do
      analytic = Work::Analytic.create! valid_attributes
      get :index, {}, valid_session
      assigns(:work_analytics).should eq([analytic])
    end
  end

  describe "GET show" do
    it "assigns the requested work_analytic as @work_analytic" do
      analytic = Work::Analytic.create! valid_attributes
      get :show, {:id => analytic.to_param}, valid_session
      assigns(:work_analytic).should eq(analytic)
    end
  end

  describe "GET new" do
    it "assigns a new work_analytic as @work_analytic" do
      get :new, {}, valid_session
      assigns(:work_analytic).should be_a_new(Work::Analytic)
    end
  end

  describe "GET edit" do
    it "assigns the requested work_analytic as @work_analytic" do
      analytic = Work::Analytic.create! valid_attributes
      get :edit, {:id => analytic.to_param}, valid_session
      assigns(:work_analytic).should eq(analytic)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Work::Analytic" do
        expect {
          post :create, {:work_analytic => valid_attributes}, valid_session
        }.to change(Work::Analytic, :count).by(1)
      end

      it "assigns a newly created work_analytic as @work_analytic" do
        post :create, {:work_analytic => valid_attributes}, valid_session
        assigns(:work_analytic).should be_a(Work::Analytic)
        assigns(:work_analytic).should be_persisted
      end

      it "redirects to the created work_analytic" do
        post :create, {:work_analytic => valid_attributes}, valid_session
        response.should redirect_to(Work::Analytic.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved work_analytic as @work_analytic" do
        # Trigger the behavior that occurs when invalid params are submitted
        Work::Analytic.any_instance.stub(:save).and_return(false)
        post :create, {:work_analytic => {}}, valid_session
        assigns(:work_analytic).should be_a_new(Work::Analytic)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Work::Analytic.any_instance.stub(:save).and_return(false)
        post :create, {:work_analytic => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested work_analytic" do
        analytic = Work::Analytic.create! valid_attributes
        # Assuming there are no other work_analytics in the database, this
        # specifies that the Work::Analytic created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Work::Analytic.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => analytic.to_param, :work_analytic => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested work_analytic as @work_analytic" do
        analytic = Work::Analytic.create! valid_attributes
        put :update, {:id => analytic.to_param, :work_analytic => valid_attributes}, valid_session
        assigns(:work_analytic).should eq(analytic)
      end

      it "redirects to the work_analytic" do
        analytic = Work::Analytic.create! valid_attributes
        put :update, {:id => analytic.to_param, :work_analytic => valid_attributes}, valid_session
        response.should redirect_to(analytic)
      end
    end

    describe "with invalid params" do
      it "assigns the work_analytic as @work_analytic" do
        analytic = Work::Analytic.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Work::Analytic.any_instance.stub(:save).and_return(false)
        put :update, {:id => analytic.to_param, :work_analytic => {}}, valid_session
        assigns(:work_analytic).should eq(analytic)
      end

      it "re-renders the 'edit' template" do
        analytic = Work::Analytic.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Work::Analytic.any_instance.stub(:save).and_return(false)
        put :update, {:id => analytic.to_param, :work_analytic => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested work_analytic" do
      analytic = Work::Analytic.create! valid_attributes
      expect {
        delete :destroy, {:id => analytic.to_param}, valid_session
      }.to change(Work::Analytic, :count).by(-1)
    end

    it "redirects to the work_analytics list" do
      analytic = Work::Analytic.create! valid_attributes
      delete :destroy, {:id => analytic.to_param}, valid_session
      response.should redirect_to(work_analytics_url)
    end
  end

end
