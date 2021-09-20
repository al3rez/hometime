require 'rails_helper'

RSpec.describe Reservation, type: :model do
    subject do
      guest = Guest.create!(email: "unique@gmail.com")
      guest.reservations.create!(reservation_code: "unique")
    end

    it { is_expected.to belong_to(:guest) }
    it { is_expected.to validate_uniqueness_of(:reservation_code) }
end
