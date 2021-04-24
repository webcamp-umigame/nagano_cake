class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  #おそらくoderに移動
  def top
    # @oders = Oder.all
  end
end
