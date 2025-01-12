class CardsController < ApplicationController
  def new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end
end