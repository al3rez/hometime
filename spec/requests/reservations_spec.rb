require 'rails_helper'

RSpec.describe "Reservations", type: :request do
    let!(:airbnb_params) {{
      "reservation_code": "YYY12345678",
      "start_date": "2021-04-14",
      "end_date": "2021-04-18",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbridge@bnb.com"
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00"
    }}

    let!(:booking_params) {{
        "reservation": {
          "code": "XXX12345678",
          "start_date": "2021-03-12",
          "end_date": "2021-03-16",
          "expected_payout_amount": "3800.00",
          "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
          },
          "guest_email": "wayne_woodbridge@bnb.com",
          "guest_first_name": "Wayne",
          "guest_last_name": "Woodbridge",
          "guest_phone_numbers": [
            "639123456789",
            "639123456789"
          ],
          "listing_security_price_accurate": "500.00",
          "host_currency": "AUD",
          "nights": 4,
          "number_of_guests": 4,
          "status_type": "accepted",
          "total_paid_amount_accurate": "4300.00"
        }
      }
    }

  describe 'create' do
    context "with booking params" do
      it "creates a new reservation" do
        post "/reservations", params: booking_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with airbnb params" do
      it "creates a new reservation" do
        post "/reservations", params: airbnb_params
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'update' do
    context "with airbnb params" do
      it "updates the reservation attributes" do
        # Create a new reservation
        post "/reservations", params: airbnb_params
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["nights"]).to eq 4 
        expect(response.parsed_body["status"]).to eq "accepted"

        # Update the old reservation nights, status and etc
        post "/reservations", params: airbnb_params.merge(nights: 10, status: 'declined')
        expect(response).to have_http_status(:ok)
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["nights"]).to eq 10 
        expect(response.parsed_body["status"]).to eq "declined"
      end
    end

    context "with booking_params params" do
      it "updates the reservation attributes" do
        # Create a new reservation
        post "/reservations", params: booking_params
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["nights"]).to eq 4 
        expect(response.parsed_body["status"]).to eq "accepted"

        # Update the old reservation nights, status and etc
        booking_params[:reservation][:nights] = 10
        booking_params[:reservation][:status_type] = 'declined'
        post "/reservations", params: booking_params
        expect(response).to have_http_status(:ok)
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["nights"]).to eq 10 
        expect(response.parsed_body["status"]).to eq "declined"
      end
    end
  end
end
