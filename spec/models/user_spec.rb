require "rails_helper"

RSpec.describe User do
  it "builds valid students and teachers" do
    expect(build(:student)).to be_valid
    expect(build(:teacher)).to be_valid
    expect(build(:teacher)).to be_teacher
  end

  it "rejects an unknown role" do
    expect(build(:user, role: "principal")).not_to be_valid
  end
end
