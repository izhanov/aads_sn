require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:surname).of_type(:string).with_options(null: false) }
  it { is_expected.to have_db_column(:phone).of_type(:string).with_options(null: false) }
end
