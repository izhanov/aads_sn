# frozen_string_literal: true

RSpec.describe Operations::My::UserFollows::Accept do
  describe ".run" do
    context "when user is not found" do
      it "returns a failure" do
        followed = create(:user)

        operation = described_class.run(follower_id: 42, followed: followed)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:follower_not_found, "Follower not found"])
      end
    end

    context "when user is following the follower" do
      it "returns a success" do
        follower = create(:user)
        followed = create(:user)
        followed.user_followers.create!(follower: follower)

        operation = described_class.run(follower_id: follower.id, followed: followed)

        expect(operation).to be_success
        expect(operation.value!).to eq(follower)
      end
    end

    context "when user is following itself" do
      it "returns a failure" do
        follower = create(:user)

        operation = described_class.run(follower_id: follower.id, followed: follower)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:follower_not_found, "Follower not found"])
      end
    end

    context "when user is not following the followed user" do
      it "returns a failure" do
        follower = create(:user)
        followed = create(:user)

        operation = described_class.run(follower_id: follower.id, followed: followed)

        expect(operation).to be_failure
        expect(operation.failure).to match_array([:follower_not_found, "Follower not found"])
      end
    end
  end
end
