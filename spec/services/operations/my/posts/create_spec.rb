# frozen_string_literal: true

RSpec.describe Operations::My::Posts::Create do
  describe ".run" do
    context "when params are valid" do
      let(:user) { create(:user) }

      it "creates a post" do
        post_params = {
          user_id: user.id,
          title: "Title",
          content: "Content"
        }

        operation = described_class.run(post_params)
        result = operation.value!

        expect(operation).to be_success
        expect(result).to be_a(Post)
        expect(result.title).to eq("Title")
        expect(result.content).to eq("Content")
      end
    end
  end
end
