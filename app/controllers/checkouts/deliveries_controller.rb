module Checkouts
  class DeliveriesController < MasterController
    private

    def checkout_params
      params.required(:checkout).permit(:delivery_id).merge(stage: Checkout::STAGES[:delivery])
    end
  end
end
