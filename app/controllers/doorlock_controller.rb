class DoorlockController < ApplicationController
  def index
    @doorlock = Doorlock.last
  end
end
