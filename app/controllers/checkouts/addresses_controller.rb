module Checkouts
  class AddressesController < ApplicationController
    before_action :authenticate_user!

    def show
      puts '====addresses controller ===>'
      render :show
    end
  end
end
