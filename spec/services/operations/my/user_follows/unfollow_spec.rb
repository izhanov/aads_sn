# frozen_string_literal: true

RSpec.describe Operations::My::UserFollows::Unfollow do
  describe ".run" do
    context "when followed user is the same as the follower" do
      it "returns a failure" do
        follower = create(:user)
        operation = described_class.run(followed: follower, follower: follower)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:self_following, "You cannot unfollow yourself"])
      end
    end

    context "when followed user is not being followed" do
      it "returns a failure" do
        follower = create(:user)
        followed = create(:user)

        operation = described_class.run(followed: followed, follower: follower)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:not_following, "You are not following this user"])
      end
    end

    context "when followed user is being followed" do
      it "returns a success" do
        follower = create(:user)
        followed = create(:user)
        followed.followers.create!(follower: follower, status: "APPROVED")

        operation = described_class.run(followed: followed, follower: follower)

        expect(operation).to be_success
        expect(operation.value!).to eq(followed)
      end
    end
  end
end
