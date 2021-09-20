class ReservationsController < ApplicationController
  include MappableParams
  before_action :prepare_attributes
  before_action :find_or_initialize_reservation

  def create
    @reservation.guest.attributes = @attributes.delete(:guest_attributes) if @reservation.guest.present?
    @reservation.attributes = @attributes

    if @reservation.save
      render json: @reservation
    else
      render json: @reservation.errors
    end
  end

  private

  def find_or_initialize_reservation
    @reservation = Reservation
      .find_or_initialize_by(reservation_code: @attributes[:reservation_code])
  end

  def prepare_attributes
    @attributes = prepare_attributes_from(params)
  end
end
