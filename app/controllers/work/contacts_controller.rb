class Work::ContactsController < Work::WorkBaseController
  load_and_authorize_resource
  Model_class = Contact.new.class

  # GET /work/contacts
  # GET /work/contacts.json
  def index
    @work_contacts = Contact.all.entries

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), work_contacts_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @work_contacts }
    end
  end

  # GET /work/contacts/1
  # GET /work/contacts/1.json
  def show
    @work_contact = Contact.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), work_contact_path(@work_contact)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work_contact }
    end
  end

  # GET /work/contacts/new
  # GET /work/contacts/new.json
  def new
    @work_contact = Contact.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_work_contact_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work_contact }
    end
  end

  # GET /work/contacts/1/edit
  def edit
    @work_contact = Contact.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_work_contact_path(@work_contact)
  end

  # POST /work/contacts
  # POST /work/contacts.json
  def create
    @work_contact = Contact.new(params[:contact])

    respond_to do |format|
      if @work_contact.save
        format.html { redirect_to [:work,@work_contact], notice: 'Contact was successfully created.' }
        format.json { render json: @work_contact, status: :created, location: @work_contact }
      else
        format.html { render action: "new" }
        format.json { render json: @work_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /work/contacts/1
  # PUT /work/contacts/1.json
  def update
    @work_contact = Contact.find(params[:id])

    respond_to do |format|
      if @work_contact.update_attributes(params[:contact])
        format.html { redirect_to [:work,@work_contact], notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work/contacts/1
  # DELETE /work/contacts/1.json
  def destroy
    @work_contact = Contact.find(params[:id])
    @work_contact.destroy

    respond_to do |format|
      format.html { redirect_to work_contacts_url }
      format.json { head :no_content }
    end
  end
end
