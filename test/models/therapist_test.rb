require 'test_helper'

class TherapistTest < ActiveSupport::TestCase
  def setup
    @therapist = Therapist.new(
      first_name: "Jane",
      last_name: "Doe",
      email: "patient@example.com",
      password: "foobar",
      password_confirmation: "foobar",
      profession: "doctor",
      prefix: "Mr.",
      code: "adbhjsfbas"
    )
  end

  test "should be valid" do
    assert @therapist.valid?
  end

  test "first name should be present" do
    @therapist.first_name = "     "
    assert_not @therapist.valid?
  end

  test "last name should be present" do
    @therapist.last_name = "     "
    assert_not @therapist.valid?
  end

  test "email should be present" do
    @therapist.email = "     "
    assert_not @therapist.valid?
  end

  test "email should be valid" do
    @therapist.email = "invalidemail"
    assert_not @therapist.valid?
  end

  test "profession should be present" do
    @therapist.profession = nil
    assert_not @therapist.valid?
  end

  test "prefix should be present" do
    @therapist.prefix = nil
    assert_not @therapist.valid?
  end

  test "password should be present" do
    @therapist.password = nil
    @therapist.password_confirmation = nil
    assert_not @therapist.valid?
  end

  test "passwords should match be present" do
    @therapist.password = "asd"
    @therapist.password_confirmation = "asdf"
    assert_not @therapist.valid?
  end
end
