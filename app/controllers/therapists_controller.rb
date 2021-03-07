class TherapistsController < ApplicationController
  before_action :set_therapist, only: [:show, :update, :destroy, :patients]
  before_action :set_body, only: [:show, :login, :create, :update, :destroy, :patients]

  include SessionsHelper

  # GET /therapists
  # GET /therapists.json
  def index
    @therapists = Therapist.all
  end

  # GET /therapists/1
  # GET /therapists/1.json
  def show
  end

  def patients
    therapist = get_therapist(@body["token"])
    if @therapist != therapist
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    else
      patients = therapist.patients.map do |patient|
        {
          email: patient.email,
          firstName: patient.first_name,
          lastName: patient.last_name,
          birthday: patient.birthday,
          height: patient.height,
          weight: patient.weight,
        }
      end

      render json: patients
    end
  end


  def login
    @therapist = Therapist.find_by(email: @body["email"].downcase)
    if @therapist.authenticate
      render :json => {
        id: @therapist.id,
        email: @therapist.email,
        firstName: @therapist.first_name,
        lastName: @therapist.last_name,
        prefix: @therapist.prefix,
        profession: @therapist.profession,
        code: @therapist.code,
        token: get_token(@therapist)
       }
    else
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    end
  end


  # GET /therapists/new
  def new
    @therapist = Therapist.new
  end


  # GET /therapists/1/edit
  def edit
  end

  # POST /therapists
  # POST /therapists.json
  def create
    @therapist = Therapist.new(therapist_params.merge({code: create_code}))
    if @therapist.save
      render :json => {
         id: @therapist.id,
         email: @therapist.email,
         firstName: @therapist.first_name,
         lastName: @therapist.last_name,
         prefix: @therapist.prefix,
         profession: @therapist.profession,
         code: @therapist.code,
         token: get_token(@therapist)
        }
    else
      render json: @therapist.errors, status: :unprocessable_entity
      # render json: @therapist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /therapists/1
  # PATCH/PUT /therapists/1.json
  def update
    respond_to do |format|
      if @therapist.update(therapist_params)
        format.html { redirect_to @therapist, notice: 'Therapist was successfully updated.' }
        format.json { render :show, status: :ok, location: @therapist }
      else
        format.html { render :edit }
        format.json { render json: @therapist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /therapists/1
  # DELETE /therapists/1.json
  def destroy
    @therapist.destroy
    respond_to do |format|
      format.html { redirect_to therapists_url, notice: 'Therapist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_therapist
      @therapist = Therapist.find(params[:id])
    end

    def set_body
      @body = ActiveSupport::JSON.decode(request.body.read)
    end

    # Only allow a list of trusted parameters through.
    def therapist_params
      @body
    end

    def create_code
      code = SecureRandom.hex(3) # or whatever you chose like UUID tools
      while Therapist.exists?(:code => code) do
        code = SecureRandom.hex(3) # or whatever you chose like UUID tools
      end
      code
    end
end
