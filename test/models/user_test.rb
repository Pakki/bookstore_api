require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "user with a valid email should be valid" do
    user = User.new(email: "test@test.com", password_digest: "1q2w3e")
    assert user.valid?
  end

  test "user with invalid email should be invalid" do
    user = User.new(email: "test", password_digest: "1q2w3e")
    assert_not user.valid?
  end

  test "user after creation shoul have cart" do
    user = User.new(email: "special@test.com", password: "1q2w3e", password_confirmation: "1q2w3e")
    user.save
    assert user.cart
  end
end
