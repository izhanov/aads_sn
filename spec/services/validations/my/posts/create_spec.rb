# frozen_string_literal: true

RSpec.describe Validations::My::Posts::Create do
  it "requires user_id" do
    result = subject.call({})

    expect(result.errors[:user_id]).to include("is missing")
  end

  it "requires title" do
    result = subject.call({user_id: 1})

    expect(result.errors[:title]).to include("is missing")
  end

  it "requires content" do
    result = subject.call({user_id: 1, title: "Title"})

    expect(result.errors[:content]).to include("is missing")
  end
end
