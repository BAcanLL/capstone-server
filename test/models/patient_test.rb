require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  def setup
    @patient = Patient.new(first_name: "Jane", last_name: "Doe", email: "patient@example.com")
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

  test "height should be present" do
    @patient.height = "     "
    assert_not @patient.valid?
  end

  test "weight should be present" do
    @patient.weight = "     "
    assert_not @patient.valid?
  end

  test "password should be present" do
    @patient.password = "     "
    assert_not @patient.valid?
  end
end
