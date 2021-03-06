class PeopleController < ApplicationController
  # GET /people
  # GET /people.json
  def index

    

    @people = Person.all
    if not session[:admin_id]
      redirect_to adm_path
    else

    respond_to do |format|
      format.html # index.html.erb


      format.json { render json: @people }
    end
  end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    if not session[:admin_id]
      redirect_to adm_path
    else
    @person = Person.find(params[:id])
    @adminpage = true
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new
    @isremote = true
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    if not session[:admin_id]
      redirect_to adm_path
    end
    @isremote = false
    @person = Person.find(params[:id])
    

  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])
    @typeselected = @person.persontype

    respond_to do |format|
      if @person.save
        @saved = true
        format.html { redirect_to root_path, notice: 'Person was successfully created.' }
        format.js
        format.json { render json: @person, status: :created, location: @person }
      else        
        format.js
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end
end
