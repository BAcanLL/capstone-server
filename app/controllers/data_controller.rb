class DataController < ApplicationController
  before_action :set_patient, only: [:store_raw, :store_data, :ecg_raw]
  before_action :set_body, only: [:store_raw, :store_data, :ecg_raw]

  include SessionsHelper

  def store_raw
    if !is_authenticated?
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    else
      ecg = Ecg.new(ecg_params)
      ecg_raw = EcgRaw.new(ecg_raw_params)
      ecg_raw.ecg = ecg
      if !ecg.valid?
        render json: ecg.errors, status: :unprocessable_entity
      elsif !ecg_raw.valid?
        render json: ecg_raw.errors, status: :unprocessable_entity
      else
        ActiveRecord::Base.transaction do
          ecg.save!
          ecg_raw.save!
        end
        render json: {message: "success"}
      end
    end
  rescue
    render json: {message: "failed to add records"}, status: :unprocessale_entity
  end

  def store_data
    @ecg = @patient.ecgs.find(@body["ecg_id"])
    if !is_authenticated?
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @ecg.nil?
      render json: {message: "failed to find ecg"}, status: :unprocessable_entity
    else
      ecg_data = EcgDatum.new(ecg_data_params)
      ecg_data.ecg = @ecg
      if ecg_data.save
        render json: {message: "success"}
      else
        render json: ecg_data.errors, status: :unprocessable_entity
      end
    end
  end

  def ecg_raw
    @ecgs = @patient.ecgs&.last(@body["limit"])
    if !is_authenticated?
      render json: {message: "failed to authenticate"}, status: :unprocessable_entity
    elsif @ecgs.nil? || @ecgs.empty?
      render json: {message: "failed to find ecgs"}, status: :unprocessable_entity
    else
      raw_ecgs = @ecgs.map do |ecg|
        raw = ecg.ecg_raw
        {
          id: ecg.id,
          recorded_date: ecg.recorded_date,
          classification: raw.classification,
          symptoms: raw.symptoms,
          device: raw.device,
          sample_rate: raw.sample_rate,
          unit: raw.unit,
          values: raw.values,
        }
      end
      render json: raw_ecgs
    end
  end

private
  def set_body
    @body = ActiveSupport::JSON.decode(request.body.read)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def is_authenticated?
    @body["token"] == "doggos-go-bork"
  end

  def ecg_raw_params
    {
      classification: @body["classification"],
      symptoms: @body["symptoms"],
      device: @body["device"],
      sample_rate: @body["sample_rate"],
      unit: @body["unit"],
      values: @body["values"],
    }
  end

  def ecg_params
    {
      patient_id: @patient.id,
      recorded_data: @body["recorded_date"]
    }
  end

  def ecg_data_params
    {
      hr: @body["hr"],
      hrv: @body["hrv"],
      pnn50: @body["pnn50"],
      nn50: @body["nn50"],
      lfhf: @body["lfhf"],
      anomaly: @body["anomaly"],
    }
  end
end
