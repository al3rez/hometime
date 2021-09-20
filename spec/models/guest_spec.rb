require 'rails_helper'

RSpec.describe Guest, type: :model do
  it { should have_many(:reservations) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
end
