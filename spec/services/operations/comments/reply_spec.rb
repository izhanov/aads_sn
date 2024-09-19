# frozen_string_literal: true

RSpec.describe Operations::My::Comments::Reply do
  let!(:author) { create(:user) }
  let!(:commentable) { create(:post) }
  let(:content) { "Some content" }
  let!(:parent_comment) { create(:comment) }

  describe ".run" do
    subject(:run) { described_class.run(author: author, commentable: commentable, content: content, parent_comment: parent_comment) }

    it "creates a comment" do
      expect { run }.to change { Comment.count }.by(1)
    end

    it "returns a success result" do
      expect(run).to be_success
    end

    context "when content is blank" do
      let(:content) { "" }

      it "does not create a comment" do
        expect { run }.not_to change { Comment.count }
      end

      it "returns a failure result" do
        expect(run).to be_failure
      end

      it "returns a validation error" do
        expect(run.failure).to match_array([:validation_error, { content: ["can't be blank"] }])
      end
    end
  end

  # describe "#call" do
  #   subject(:call) { operation.call(author: author, commentable: commentable, content: content, parent_comment: parent_comment) }

  #   it "creates a comment" do
  #     expect { call }.to change { Comment.count }.by(1)
  #   end

  #   it "returns a success result" do
  #     expect(call).to be_success
  #   end

  #   context "when content is blank" do
  #     let(:content) { "" }

  #     it "does not create a comment" do
  #       expect { call }.not_to change { Comment.count }
  #     end

  #     it "returns a failure result" do
  #       expect(call).to be_failure
  #     end

  #     it "returns a validation error" do
  #       expect(call.failure).to match_array([:validation_error, { content: ["can't be blank"] }])
  #     end
  #   end
  # end
end
