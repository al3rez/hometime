class Reservation < ApplicationRecord
  belongs_to :guest
  accepts_nested_attributes_for :guest

  enum status: {accepted: 0, declined: 1}

  validates :reservation_code, presence: true, uniqueness: true, on: :create

  def as_json(*)
    super.merge(guest: guest.attributes)
  end
end
