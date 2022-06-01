# frozen_string_literal: true

require "test_helper"

class TestInGroup < Minitest::Spec
  it "defines groups which can be used to query members from database and query instances" do
    InGroup.define(User) do |groups|
      groups.add(:beatles, id: [1, 2, 3, 5])
      groups.add(:songwriters, id: [1, 2])
      groups.add(:songwriters, name: "George")
    end

    beatles = User.where(name: %w[John Paul George Ringo])
    assert_equal(
      beatles.sort,
      User.in_group(:beatles).sort
    )
    beatles.each do |user|
      assert_equal true, user.in_group?(:beatles)
    end
    assert_equal false, User.find_by_name("Pete").in_group?(:beatles)

    songwriters = User.where(name: %w[John Paul George])
    assert_equal(
      songwriters.sort,
      User.in_group(:songwriters).sort
    )
    songwriters.each do |user|
      assert_equal true, user.in_group?(:songwriters)
    end

    drummers = User.where(name: %(Pete Ringo))
    drummers.each do |user|
      assert_equal false, user.in_group?(:songwriters)
    end
  end
end
