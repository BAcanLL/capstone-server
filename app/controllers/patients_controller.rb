class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :update, :therapist, :associate, :ecg_data, :destroy, :emote, :note, :medication, :word]
  before_action :set_body, only: [:show, :create, :login, :therapist, :associate, :update, :ecg_data, :destroy, :emote, :note, :medication, :word]

  include SessionsHelper

  # GET /patients/1
  # GET /patients/1.json
  def show
    patient = get_patient(@body["token"])
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    else
      render :json => {
        id: @patient.id,
        email: @patient.email,
        firstName: @patient.first_name,
        lastName: @patient.last_name,
        birthday: @patient.birthday,
        height: @patient.height,
        weight: @patient.weight,
        token: get_token(@patient)
       }
    end
  end

  def login
    @patient = Patient.find_by(email: @body["email"].downcase)
    if @patient.authenticate(@body["password"])
      render :json => {
        id: @patient.id,
        email: @patient.email,
        firstName: @patient.first_name,
        lastName: @patient.last_name,
        birthday: @patient.birthday,
        height: @patient.height,
        weight: @patient.weight,
        token: get_token(@patient)
       }
    else
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    end
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      render :json => {
         id: @patient.id,
         email: @patient.email,
         firstName: @patient.first_name,
         lastName: @patient.last_name,
         birthday: @patient.birthday,
         height: @patient.height,
         weight: @patient.weight,
         token: get_token(@patient)
        }
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    patient = get_patient(@body["token"])
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @patient.update(patient_params)
      render :json => {
        id: @patient.id,
        email: @patient.email,
        firstName: @patient.first_name,
        lastName: @patient.last_name,
        birthday: @patient.birthday,
        height: @patient.height,
        weight: @patient.weight,
        token: get_token(@patient)
       }
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    patient = get_patient(@body["token"])
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @patient.destroy
      render json: {message: "success"}
    else
      render json: {message: "failed"}, status: :unprocessable_entity
    end
  end

  def emote
    patient = get_patient(@body["token"])
    @emote = Emote.new(emote_params.merge(patient_id: @patient.id))
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @emote.save
      render json: {message: "success"}
    else
      render json: {message: "failed"}, status: :unprocessable_entity
    end
  end

  def word
    patient = get_patient(@body["token"])
    @word = Word.new(word_params.merge(patient_id: @patient.id))
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @word.save
      render json: {message: "success"}
    else
      render json: {message: "failed"}, status: :unprocessable_entity
    end
  end

  def medication
    patient = get_patient(@body["token"])
    @medication = Medication.new(medication_params.merge(patient_id: @patient.id))
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @medication.save
      render json: {message: "success"}
    else
      render json: {message: "failed"}, status: :unprocessable_entity
    end
  end

  def note
    patient = get_patient(@body["token"])
    @note = Note.new(note_params.merge(patient_id: @patient.id))
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @note.save
      render json: {message: "success"}
    else
      render json: {message: "failed"}, status: :unprocessable_entity
    end
  end

  def associate
    patient = get_patient(@body["token"])
    therapist = Therapist.find_by(code: @body["code"])
    if patient != @patient || therapist.nil?
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    else
      patient.therapist_id = therapist.id
      if patient.save
        render json: {message: "success"}
      else
        render json: {message: "failed"}, status: :unprocessable_entity
      end
    end
  end

  def unassociate
    patient = get_patient(@body["token"])
    patient.therapist_id = nil
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif patient.save
      render json: {message: "success"}
    else
      render json: {message: "failed"}, status: :unprocessable_entity
    end
  end

  def therapist
    patient = get_patient(@body["token"])
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    else
      @therapist = patient.therapist
      render json: {
        email: @therapist&.email,
        firstName: @therapist&.first_name,
        lastName: @therapist&.last_name,
        prefix: @therapist&.prefix,
        profession: @therapist&.profession,
      }
    end
  end

  def ecg_data
    patient = get_patient(@body["token"])
    @ecgs = @patient.ecgs
    if patient != @patient
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @ecgs.nil? || @ecgs.empty?
      render json: {message: "failed to find ecgs"}, status: :unprocessable_entity
    else
      data_ecgs = @ecgs.map do |ecg|
        data = ecg.ecg_data
        {
          id: ecg.id,
          recorded_date: ecg.recorded_data,
          hr: data.hr,
          hrv: data.hrv,
          pnn50: data.pnn50,
          nn50: data.nn50,
          lfhf: data.lfhf,
          anomaly: data.anomaly,
        }
      end
      render json: data_ecgs
    end
  end

  private
    def set_body
      @body = ActiveSupport::JSON.decode(request.body.read)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      {
        email: @body["email"],
        password: @body["password"],
        password_confirmation: @body["password_confirmation"],
        first_name: @body["first_name"],
        last_name: @body["last_name"],
        height: @body["height"],
        weight: @body["weight"],
        birthday: @body["birthday"],
      }
    end

    def emote_params
      {
        time: @body["time"],
        value: @body["value"],
      }
    end

    def note_params
      {
        time: @body["time"],
        text: @body["text"],
      }
    end

    def medication_params
      {
        time: @body["time"],
        name: @body["name"],
      }
    end

    def word_params
      {
        time: @body["time"],
        value: @body["value"],
      }
    end
end
