# frozen_string_literal: true

RSpec.describe Operations::My::UserFollows::Reject do
  describe ".run" do
    context "when followed user is the same as the follower" do
      it "returns a failure" do
        followed = create(:user)
        operation = described_class.run(follower_id: followed.id, followed: followed)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:self_following, "You cannot reject yourself"])
      end
    end

    context "when followed user is not being followed" do
      it "returns a failure" do
        follower = create(:user)
        followed = create(:user)

        operation = described_class.run(follower_id: follower.id, followed: followed)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:not_following, "Follower not follow this user"])
      end
    end

    context "when followed user is being followed" do
      it "returns a success" do
        follower = create(:user)
        followed = create(:user)
        followed.followers.create!(follower: follower)

        operation = described_class.run(follower_id: follower.id, followed: followed)

        expect(operation).to be_success
        expect(operation.value!).to eq(follower)
      end
    end
  end
end
