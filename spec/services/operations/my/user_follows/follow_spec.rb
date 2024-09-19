# frozen_string_literal: true

RSpec.describe Operations::My::UserFollows::Follow do
  describe ".run" do
    context "when followed user does not exist" do
      it "returns a failure" do
        follower = create(:user)
        operation = described_class.run(followed_id: 42, follower: follower)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:not_found, "User not found"])
      end
    end

    context "when followed user is the same as the follower" do
      it "returns a failure" do
        follower = create(:user)
        operation = described_class.run(followed_id: follower.id, follower: follower)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:self_following, "You cannot follow yourself"])
      end
    end

    context "when followed user is already being followed" do
      it "returns a failure" do
        follower = create(:user)
        followed = create(:user)
        followed.followers.create!(follower: follower)

        operation = described_class.run(followed_id: followed.id, follower: follower)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:already_following, "You are already following this user"])
      end
    end

    context "when followed user is not being followed" do
      it "returns a success" do
        follower = create(:user)
        followed = create(:user)

        operation = described_class.run(followed_id: followed.id, follower: follower)

        expect(operation).to be_success
        expect(operation.value!).to eq(followed)
      end
    end
  end
end
