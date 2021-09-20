class AirbnbParamsMapper < Hash
  include Callable
  attr_reader :params

  def initialize(params)
    @params = params.permit!
    @params[:guest] ||= {}
  end

  def call
    reservation_attributes.merge(guest_attributes: guest_attributes)
  end

  private

  def reservation_attributes
    {
      reservation_code: params[:reservation_code],
      start_date:       params[:start_date],
      end_date:         params[:end_date],
      nights:           params[:nights],
      guests:           params[:guests],
      adults:           params[:adults],
      children:         params[:children],
      infants:          params[:infants],
      status:           params[:status],
      currency:         params[:currency],
      payout_price:     params[:payout_price],
      security_price:   params[:security_price],
      total_price:      params[:total_price],
    }
  end

  def guest_attributes
    return {} if params[:guest].blank?

    {
        email:         params[:guest][:email],
        first_name:    params[:guest][:first_name],
        last_name:     params[:guest][:last_name],
        phone_numbers: Array.wrap(params[:guest][:phone]),
    }
  end
end
