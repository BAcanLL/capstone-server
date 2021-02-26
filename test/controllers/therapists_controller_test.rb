require 'test_helper'

class TherapistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @therapist = therapists(:one)
  end

  # test "should get index" do
  #   get therapists_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_therapist_url
  #   assert_response :success
  # end

  test "should fail to create therapist" do
    post therapists_url, params: {
      therapist: {
        email: @therapist.email,
        first_name: @therapist.first_name,
        last_name: @therapist.last_name,
        password: "foobar",
        password_confirmation: "foobar",
        prefix: @therapist.prefix,
        profession: @therapist.profession
        }
    }
    assert(@response.status == 422)
    assert(@response.parsed_body["email"]==["has already been taken"])
  end

  test "should create therapist" do
    assert_difference('Therapist.count') do
      post therapists_url, params: {
        therapist: {
          email: "unique@email.com",
          first_name: @therapist.first_name,
          last_name: @therapist.last_name,
          password: "foobar",
          password_confirmation: "foobar",
          prefix: @therapist.prefix,
          profession: @therapist.profession
          }
      }
    end
    assert(@response.status == 200)
    assert(@response.parsed_body["id"] == Therapist.last.id)
    assert(@response.parsed_body["email"] == "unique@email.com")
    assert(@response.parsed_body["firstName"] == @therapist.first_name)
    assert(@response.parsed_body["lastName"] == @therapist.last_name)
    assert(@response.parsed_body["prefix"] == @therapist.prefix)
    assert(@response.parsed_body["profession"] == @therapist.profession)
    assert(@response.parsed_body["code"] == Therapist.last.code)
    assert(@response.parsed_body["token"].present?)

  end

  # test "should show therapist" do
  #   get therapist_url(@therapist)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_therapist_url(@therapist)
  #   assert_response :success
  # end

  # test "should update therapist" do
  #   patch therapist_url(@therapist), params: { therapist: { email: @therapist.email, first_name: @therapist.first_name, last_name: @therapist.last_name, password_digest: @therapist.password_digest, prefix: @therapist.prefix, profession: @therapist.profession } }
  #   assert_redirected_to therapist_url(@therapist)
  # end

  # test "should destroy therapist" do
  #   assert_difference('Therapist.count', -1) do
  #     delete therapist_url(@therapist)
  #   end

  #   assert_redirected_to therapists_url
  # end
end
