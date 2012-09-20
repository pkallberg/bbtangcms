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

describe Recommend::OtherColumnsController do

  # This should return the minimal set of attributes required to create a valid
  # Recommend::OtherColumn. As you add validations to Recommend::OtherColumn, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Recommend::OtherColumnsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all recommend_other_columns as @recommend_other_columns" do
      other_column = Recommend::OtherColumn.create! valid_attributes
      get :index, {}, valid_session
      assigns(:recommend_other_columns).should eq([other_column])
    end
  end

  describe "GET show" do
    it "assigns the requested recommend_other_column as @recommend_other_column" do
      other_column = Recommend::OtherColumn.create! valid_attributes
      get :show, {:id => other_column.to_param}, valid_session
      assigns(:recommend_other_column).should eq(other_column)
    end
  end

  describe "GET new" do
    it "assigns a new recommend_other_column as @recommend_other_column" do
      get :new, {}, valid_session
      assigns(:recommend_other_column).should be_a_new(Recommend::OtherColumn)
    end
  end

  describe "GET edit" do
    it "assigns the requested recommend_other_column as @recommend_other_column" do
      other_column = Recommend::OtherColumn.create! valid_attributes
      get :edit, {:id => other_column.to_param}, valid_session
      assigns(:recommend_other_column).should eq(other_column)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Recommend::OtherColumn" do
        expect {
          post :create, {:recommend_other_column => valid_attributes}, valid_session
        }.to change(Recommend::OtherColumn, :count).by(1)
      end

      it "assigns a newly created recommend_other_column as @recommend_other_column" do
        post :create, {:recommend_other_column => valid_attributes}, valid_session
        assigns(:recommend_other_column).should be_a(Recommend::OtherColumn)
        assigns(:recommend_other_column).should be_persisted
      end

      it "redirects to the created recommend_other_column" do
        post :create, {:recommend_other_column => valid_attributes}, valid_session
        response.should redirect_to(Recommend::OtherColumn.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recommend_other_column as @recommend_other_column" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::OtherColumn.any_instance.stub(:save).and_return(false)
        post :create, {:recommend_other_column => {}}, valid_session
        assigns(:recommend_other_column).should be_a_new(Recommend::OtherColumn)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::OtherColumn.any_instance.stub(:save).and_return(false)
        post :create, {:recommend_other_column => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested recommend_other_column" do
        other_column = Recommend::OtherColumn.create! valid_attributes
        # Assuming there are no other recommend_other_columns in the database, this
        # specifies that the Recommend::OtherColumn created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Recommend::OtherColumn.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => other_column.to_param, :recommend_other_column => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested recommend_other_column as @recommend_other_column" do
        other_column = Recommend::OtherColumn.create! valid_attributes
        put :update, {:id => other_column.to_param, :recommend_other_column => valid_attributes}, valid_session
        assigns(:recommend_other_column).should eq(other_column)
      end

      it "redirects to the recommend_other_column" do
        other_column = Recommend::OtherColumn.create! valid_attributes
        put :update, {:id => other_column.to_param, :recommend_other_column => valid_attributes}, valid_session
        response.should redirect_to(other_column)
      end
    end

    describe "with invalid params" do
      it "assigns the recommend_other_column as @recommend_other_column" do
        other_column = Recommend::OtherColumn.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::OtherColumn.any_instance.stub(:save).and_return(false)
        put :update, {:id => other_column.to_param, :recommend_other_column => {}}, valid_session
        assigns(:recommend_other_column).should eq(other_column)
      end

      it "re-renders the 'edit' template" do
        other_column = Recommend::OtherColumn.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Recommend::OtherColumn.any_instance.stub(:save).and_return(false)
        put :update, {:id => other_column.to_param, :recommend_other_column => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested recommend_other_column" do
      other_column = Recommend::OtherColumn.create! valid_attributes
      expect {
        delete :destroy, {:id => other_column.to_param}, valid_session
      }.to change(Recommend::OtherColumn, :count).by(-1)
    end

    it "redirects to the recommend_other_columns list" do
      other_column = Recommend::OtherColumn.create! valid_attributes
      delete :destroy, {:id => other_column.to_param}, valid_session
      response.should redirect_to(recommend_other_columns_url)
    end
  end

end