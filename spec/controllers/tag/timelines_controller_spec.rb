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

describe Tag::TimelinesController do

  # This should return the minimal set of attributes required to create a valid
  # Tag::Timeline. As you add validations to Tag::Timeline, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Tag::TimelinesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all tag_timelines as @tag_timelines" do
      timeline = Tag::Timeline.create! valid_attributes
      get :index, {}, valid_session
      assigns(:tag_timelines).should eq([timeline])
    end
  end

  describe "GET show" do
    it "assigns the requested tag_timeline as @tag_timeline" do
      timeline = Tag::Timeline.create! valid_attributes
      get :show, {:id => timeline.to_param}, valid_session
      assigns(:tag_timeline).should eq(timeline)
    end
  end

  describe "GET new" do
    it "assigns a new tag_timeline as @tag_timeline" do
      get :new, {}, valid_session
      assigns(:tag_timeline).should be_a_new(Tag::Timeline)
    end
  end

  describe "GET edit" do
    it "assigns the requested tag_timeline as @tag_timeline" do
      timeline = Tag::Timeline.create! valid_attributes
      get :edit, {:id => timeline.to_param}, valid_session
      assigns(:tag_timeline).should eq(timeline)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Tag::Timeline" do
        expect {
          post :create, {:tag_timeline => valid_attributes}, valid_session
        }.to change(Tag::Timeline, :count).by(1)
      end

      it "assigns a newly created tag_timeline as @tag_timeline" do
        post :create, {:tag_timeline => valid_attributes}, valid_session
        assigns(:tag_timeline).should be_a(Tag::Timeline)
        assigns(:tag_timeline).should be_persisted
      end

      it "redirects to the created tag_timeline" do
        post :create, {:tag_timeline => valid_attributes}, valid_session
        response.should redirect_to(Tag::Timeline.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tag_timeline as @tag_timeline" do
        # Trigger the behavior that occurs when invalid params are submitted
        Tag::Timeline.any_instance.stub(:save).and_return(false)
        post :create, {:tag_timeline => {}}, valid_session
        assigns(:tag_timeline).should be_a_new(Tag::Timeline)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Tag::Timeline.any_instance.stub(:save).and_return(false)
        post :create, {:tag_timeline => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tag_timeline" do
        timeline = Tag::Timeline.create! valid_attributes
        # Assuming there are no other tag_timelines in the database, this
        # specifies that the Tag::Timeline created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Tag::Timeline.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => timeline.to_param, :tag_timeline => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested tag_timeline as @tag_timeline" do
        timeline = Tag::Timeline.create! valid_attributes
        put :update, {:id => timeline.to_param, :tag_timeline => valid_attributes}, valid_session
        assigns(:tag_timeline).should eq(timeline)
      end

      it "redirects to the tag_timeline" do
        timeline = Tag::Timeline.create! valid_attributes
        put :update, {:id => timeline.to_param, :tag_timeline => valid_attributes}, valid_session
        response.should redirect_to(timeline)
      end
    end

    describe "with invalid params" do
      it "assigns the tag_timeline as @tag_timeline" do
        timeline = Tag::Timeline.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Tag::Timeline.any_instance.stub(:save).and_return(false)
        put :update, {:id => timeline.to_param, :tag_timeline => {}}, valid_session
        assigns(:tag_timeline).should eq(timeline)
      end

      it "re-renders the 'edit' template" do
        timeline = Tag::Timeline.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Tag::Timeline.any_instance.stub(:save).and_return(false)
        put :update, {:id => timeline.to_param, :tag_timeline => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tag_timeline" do
      timeline = Tag::Timeline.create! valid_attributes
      expect {
        delete :destroy, {:id => timeline.to_param}, valid_session
      }.to change(Tag::Timeline, :count).by(-1)
    end

    it "redirects to the tag_timelines list" do
      timeline = Tag::Timeline.create! valid_attributes
      delete :destroy, {:id => timeline.to_param}, valid_session
      response.should redirect_to(tag_timelines_url)
    end
  end

end
