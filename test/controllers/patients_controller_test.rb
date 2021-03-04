require 'test_helper'

class PatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient = patients(:one)
  end

  test "should fail to create patient" do
    post patients_url,
      params: {
        email: @patient.email,
        first_name: @patient.first_name,
        last_name: @patient.last_name,
        password: "foobar",
        password_confirmation: "foobar",
        height: @patient.height,
        weight: @patient.weight,
        birthday: @patient.birthday
      },
      as: :json
    assert(@response.status == 422)
    assert(@response.parsed_body["email"]==["has already been taken"])
  end

  test "should create patient" do
    assert_difference('Patient.count') do
      post patients_url,
        params: {
          email: "unique@email.com",
          first_name: @patient.first_name,
          last_name: @patient.last_name,
          password: "foobar",
          password_confirmation: "foobar",
          height: @patient.height,
          weight: @patient.weight,
          birthday: @patient.birthday
        },
        as: :json
    end
    assert(@response.status == 200)
    assert(@response.parsed_body["id"] == Patient.last.id)
    assert(@response.parsed_body["email"] == "unique@email.com")
    assert(@response.parsed_body["firstName"] == @patient.first_name)
    assert(@response.parsed_body["lastName"] == @patient.last_name)
    assert(@response.parsed_body["height"] == @patient.height)
    assert(@response.parsed_body["weight"] == @patient.weight)
    assert(@response.parsed_body["birthday"].present?)
    assert(@response.parsed_body["token"].present?)

  end

  # test "should get index" do
  #   get patients_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_patient_url
  #   assert_response :success
  # end

  # test "should create patient" do
  #   assert_difference('Patient.count') do
  #     post patients_url, params: { patient: { birthday: @patient.birthday, email: @patient.email, first_name: @patient.first_name, height: @patient.height, last_name: @patient.last_name, password_digest: @patient.password_digest, weight: @patient.weight } }
  #   end

  #   assert_redirected_to patient_url(Patient.last)
  # end

  # test "should show patient" do
  #   get patient_url(@patient)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_patient_url(@patient)
  #   assert_response :success
  # end

  # test "should update patient" do
  #   patch patient_url(@patient), params: { patient: { birthday: @patient.birthday, email: @patient.email, first_name: @patient.first_name, height: @patient.height, last_name: @patient.last_name, password_digest: @patient.password_digest, weight: @patient.weight } }
  #   assert_redirected_to patient_url(@patient)
  # end

  # test "should destroy patient" do
  #   assert_difference('Patient.count', -1) do
  #     delete patient_url(@patient)
  #   end

  #   assert_redirected_to patients_url
  # end
end
