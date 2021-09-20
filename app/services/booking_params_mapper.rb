class BookingParamsMapper
  include Callable
  attr_reader :params

  def initialize(params)
    @params = params.permit!
    @params[:reservation] ||= {}
  end

  def call
    reservation_attributes.merge(guest_attributes: guest_attributes)
  end

  private

  def reservation_attributes
    {
      reservation_code: params[:reservation][:code],
      start_date:       params[:reservation][:start_date],
      end_date:         params[:reservation][:end_date],
      nights:           params[:reservation][:nights],
      guests:           params[:reservation][:number_of_guests],
      adults:           params[:reservation][:guest_details][:number_of_adults],
      children:         params[:reservation][:guest_details][:number_of_children],
      infants:          params[:reservation][:guest_details][:number_of_infants],
      status:           params[:reservation][:status_type],
      currency:         params[:reservation][:host_currency],
      payout_price:     params[:reservation][:expected_payout_amount],
      security_price:   params[:reservation][:listing_security_price_accurate],
      total_price:      params[:reservation][:total_paid_amount_accurate],
    }
  end

  def guest_attributes
    {
        email:         params[:reservation][:guest_email],
        first_name:    params[:reservation][:guest_first_name],
        last_name:     params[:reservation][:guest_last_name],
        phone_numbers: params[:reservation][:guest_phone_numbers],
    }
  end
end
