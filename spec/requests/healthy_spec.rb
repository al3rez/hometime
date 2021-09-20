require 'rails_helper'

RSpec.describe "Healthies", type: :request do
  describe "index" do
    it "simply returns a 200 to make sure app is running" do
      get "/healthy"

      expect(response).to have_http_status(:ok)
    end
  end
end
