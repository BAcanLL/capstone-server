require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  def setup
    @patient = Patient.new(
      first_name: "Jane",
      last_name: "Doe",
      email: "patient@example.com",
      password: "foobar",
      password_confirmation: "foobar",
      height: 170,
      weight: 50,
      birthday: Date.new(1990, 2,2)
    )
  end

  test "should be valid" do
    assert @patient.valid?
  end

  test "first name should be present" do
    @patient.first_name = "     "
    assert_not @patient.valid?
  end

  test "last name should be present" do
    @patient.last_name = "     "
    assert_not @patient.valid?
  end

  test "email should be present" do
    @patient.email = "     "
    assert_not @patient.valid?
  end

  test "email should be valid" do
    @patient.email = "invalidemail"
    assert_not @patient.valid?
  end

  test "height should be present" do
    @patient.height = nil
    assert_not @patient.valid?
  end

  test "weight should be present" do
    @patient.weight = nil
    assert_not @patient.valid?
  end

  test "password should be present" do
    @patient.password = nil
    @patient.password_confirmation = nil
    assert_not @patient.valid?
  end

  test "passwords should match be present" do
    @patient.password = "asd"
    @patient.password_confirmation = "asdf"
    assert_not @patient.valid?
  end
end
