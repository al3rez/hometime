module MappableParams
  extend ActiveSupport::Concern

  included do
    before_action :detect_mapper_type
    before_action :validate_mapper_type!

    private

    def prepare_attributes_from(params)
      @mapper.call(params)
    end

    def detect_mapper_type
      @mapper = BookingParamsMapper if booking?
      @mapper = AirbnbParamsMapper if airbnb?
    end

    def validate_mapper_type!
      if @mapper.blank?
        render json: {errors: ["you're missing reservation code.", "payload format is wrong. we only support airbnb and booking payloads."]}
        return
      end
    end

    def booking?
      params[:reservation] ||= {}
      params[:reservation][:code].present?
    end

    def airbnb?
      params[:reservation_code].present?
    end
  end
end
